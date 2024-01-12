# Supporting functions for the Python file type plug-in for Vim.
# Authors:
#  - Peter Odding <peter@peterodding.com>
#  - Bart Kroon <bart@tarmack.eu>
# Last Change: October 9, 2011
# URL: https://github.com/tarmack/vim-python-ftplugin

import __builtin__
import os
import platform
import re
import sys

def complete_modules(base):
  '''
  Find the names of the built-in, binary and source modules available on the
  user's system without executing any Python code except for this function (in
  other words, module name completion is completely safe).
  '''
  # Start with the names of the built-in modules.
  if base:
    modulenames = set()
  else:
    modulenames = set(sys.builtin_module_names)
  # Find the installed modules.
  for root in sys.path:
    scan_modules(root, [x for x in base.split('.') if x], modulenames)
  # Sort the module list ignoring case and underscores.
  if base:
    base += '.'
  print '\n'.join(list(modulenames))
  #return [base + modname for modname in friendly_sort(list(modulenames))]

def scan_modules(directory, base, modulenames):
  sharedext = platform.system() == 'Windows' and '\.dll' or '\.so'
  if not os.path.isdir(directory):
    return
  for name in os.listdir(directory):
    pathname = '%s/%s' % (directory, name)
    if os.path.isdir(pathname):
      listing = os.listdir(pathname)
      if '__init__' in [os.path.splitext(x)[0] for x in listing]:
        if base:
          if name == base[0]:
            scan_modules(pathname, base[1:], modulenames)
        else:
          modulenames.add(name)
    elif (not base) and re.match(r'^[A-Za-z0-9_]+(\.py[co]?|%s)$' % sharedext, name):
      name = os.path.splitext(name)[0]
      if name != '__init__':
        modulenames.add(name)

def complete_variables(expr):
  '''
  Use __import__() and dir() to get the functions and/or variables available in
  the given module or submodule.
  '''
  todo = [x for x in expr.split('.') if x]
  done = []
  attributes = []
  module = load_module(todo, done)
  subject = module
  while todo:
    if len(todo) == 1:
      expr = ('.'.join(done) + '.') if done else ''
      attributes = [expr + attr for attr in dir(subject) if attr.startswith(todo[0])]
      print '\n'.join(attributes)
    try:
      subject = getattr(subject, todo[0])
      done.append(todo.pop(0))
    except AttributeError:
      break
  if subject:
    expr = ('.'.join(done) + '.') if done else ''
    subject = [expr + entry for entry in dir(subject)]
    print '\n'.join(subject)

def load_module(todo, done):
  '''
  Find the most specific valid Python module given a tokenized identifier
  expression (e.g. `os.path' for `os.path.islink').
  '''
  path = []
  module = __builtin__
  while todo:
    path.append(todo[0])
    try:
      temp = __import__('.'.join(path))
      if temp.__name__ == '.'.join(path):
        module = temp
      else:
        break
    except ImportError:
      break
    done.append(todo.pop(0))
  return module

def find_module_path(name):
  '''
  Look for a Python module on the module search path (used for "gf" and
  searching in imported modules).
  '''
  fname = name.replace('.', '/')
  for directory in sys.path:
    scriptfile = directory + '/' + fname + '.py'
    if os.path.isfile(scriptfile):
      print scriptfile
      break

# vim: ts=2 sw=2 sts=2 et
