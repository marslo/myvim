# Type inference engine for the Python file type plug-in for Vim.
# Authors:
#  - Peter Odding <peter@peterodding.com>
#  - Bart Kroon <bart@tarmack.eu>
# Last Change: October 9, 2011
# URL: https://github.com/tarmack/vim-python-ftplugin

# TODO Nested yields don't work in Python, are there any nice alternatives? (I miss Lua's coroutines)
# http://groups.google.com/group/comp.lang.python/browse_frm/thread/fcd2709952d23e34?hl=en&lr=&ie=UTF-8&rnum=9&prev=/&frame=on

import ast
import collections

DEBUG = False
LOGFILE = '/tmp/inference.log'

# Mapping of built-ins to result types.
BUILTINS = {
    'bool': bool,
    'int': int,
    'long': long,
    'float': float,
    'str': str,
    'unicode': unicode,
    'list': list,
    'dict': dict,
    'set': set,
    'frozenset': frozenset,
    'object': object,
    'tuple': tuple,
    'file': file,
    'open': file,
    'len': int,
    'locals': dict,
    'max': int,
    'min': int,
}

# Mapping of AST types to constructors.
AST_TYPES = {
    id(ast.Num): int,
    id(ast.Str): str,
    id(ast.List): list,
    id(ast.ListComp): list,
    id(ast.Dict): dict,
}

def log(msg, *args):
  if DEBUG:
    with open(LOGFILE, 'a') as handle:
      handle.write(msg % args + '\n')

def complete_inferred_types():
  import vim
  engine = TypeInferenceEngine(vim.eval('source'))
  line = int(vim.eval('line'))
  column = int(vim.eval('column'))
  for name, types in engine.complete(line, column).iteritems():
    fields = [name]
    for t in types:
      fields.append(t.__name__)
    print '|'.join(fields)

class TypeInferenceEngine:

  def __init__(self, source):
    self.tree = ast.parse(source)
    self.link_parents(self.tree)

  def complete(self, line, column):
    node = self.find_node(line, column)
    if node:
      candidates = collections.defaultdict(list)
      for possible_type in self.evaluate(node):
        for name in dir(possible_type):
          candidates[name].append(possible_type)
      return candidates

  def link_parents(self, node):
    ''' Decorate the AST with child -> parent references. '''
    for child in self.get_children(node):
      self.link_parents(child)
      child.parent = node

  def get_parents(self, node):
    ''' Yield all parent nodes of a given AST node. '''
    while hasattr(node, 'parent'):
      node = node.parent
      yield node

  def get_children(self, node):
    ''' Get the nodes directly contained in a given AST node. '''
    nodes = []
    if isinstance(node, ast.If):
      # Might be nice to exclude "if False:" blocks here? :-)
      # TODO Take isinstance() into account as a type hint.
      nodes.append(node.test)
      nodes.extend(node.body)
      nodes.extend(node.orelse)
    elif isinstance(node, ast.Print):
      nodes.extend(node.values)
    elif isinstance(node, (ast.Expr, ast.Return)):
      nodes.append(node.value)
    elif isinstance(node, (ast.Module, ast.ClassDef)):
      nodes.extend(node.body)
    elif isinstance(node, ast.FunctionDef):
      nodes.extend(node.args.args)
      nodes.extend(node.args.defaults)
      if node.args.vararg:
        nodes.append(node.args.vararg)
      if node.args.kwarg:
        nodes.append(node.args.kwarg)
      nodes.extend(node.body)
    elif isinstance(node, ast.While):
      nodes.append(node.test)
      nodes.extend(node.body)
      nodes.extend(node.orelse)
    elif isinstance(node, ast.For):
      nodes.append(node.target)
      nodes.append(node.iter)
      nodes.extend(node.body)
      nodes.extend(node.orelse)
    elif isinstance(node, ast.Call):
      nodes.append(node.func)
      nodes.extend(node.args)
      nodes.extend(k.value for k in node.keywords)
      if node.starargs:
        nodes.append(node.starargs)
      if node.kwargs:
        nodes.append(node.kwargs)
    elif isinstance(node, (ast.Tuple, ast.List)):
      nodes.extend(node.elts)
    elif isinstance(node, ast.Dict):
      for i in xrange(len(node.values)):
        nodes.append(node.keys[i])
        nodes.append(node.values[i])
    elif isinstance(node, ast.Assign):
      nodes.extend(node.targets)
      nodes.append(node.value)
    elif isinstance(node, ast.Attribute):
      nodes.append(node.value)
      #nodes.append(node.attr)
    elif isinstance(node, ast.Import):
      #for imp in node.names:
      #  nodes.append(imp.asname or imp.name)
      pass
    elif isinstance(node, ast.ImportFrom):
      log("ImportFrom: %s", dir(node))
      node
    elif isinstance(node, (ast.Num, ast.Str, ast.Name, ast.Pass)):
      # terminals
      pass
    else:
      assert False, 'Node %s (%s) unsupported' % (node, type(node))
    return nodes

  def find_node(self, lnum, column):
    ''' Find the node at the given (line, column) in the AST. '''
    for node in ast.walk(self.tree):
      node_id = getattr(node, 'id', '')
      node_lnum = getattr(node, 'lineno', 0)
      node_col = getattr(node, 'col_offset', 0)
      if node_lnum == lnum and node_col <= column <= node_col + len(node_id):
        return node

  def evaluate(self, node):
    ''' Resolve an AST expression node to its primitive value(s). '''
    key = id(type(node))
    if key in AST_TYPES:
      # Constructor with special syntax (0, '', [], {}).
      yield AST_TYPES[key]
    elif type(node) == type:
      yield node
    elif isinstance(node, ast.Call):
      # Function call.
      # FIXME node.func can be an ast.Attribute!
      name = getattr(node.func, 'id', None)
      if name in BUILTINS:
        # Call to built-in (int(), str(), len(), max(), etc).
        yield BUILTINS[name]
      # Search return type(s) of user defined function(s).
      for func in self.find_function_definitions(node):
        for n in ast.walk(func):
          if isinstance(n, ast.Return):
            for result in self.evaluate(n.value):
              yield result
    elif isinstance(node, (ast.Tuple, ast.List)):
      if node.elts:
        for value in node.elts:
          yield value
      elif isinstance(node, ast.Tuple):
        yield tuple
      elif isinstance(node, ast.List):
        yield list
    elif isinstance(node, ast.Name):
      # Evaluate variable reference.
      for parent, kind, location in self.resolve(node):
        if isinstance(parent, ast.Assign):
          # Variable has been assigned.
          if len(parent.targets) > 1:
            # FIXME Prone to breaking on nested structures.. Use a path expression instead!
            values = self.flatten(parent.value, [])
          else:
            values = [parent.value]
          # Evaluate stand alone function call before unpacking?
          if len(values) == 1 and isinstance(values[0], ast.Call):
            values = list(self.evaluate(values[0]))
          for result in self.evaluate(values[location]):
            yield result
        elif kind == 'pos':
          # Evaluate function argument default value?
          num_required = len(parent.args.args) - len(parent.args.defaults)
          if location >= num_required:
            for result in self.evaluate(parent.args.defaults[location - num_required]):
              yield result
          # Check function arguments at potential call sites.
          for call in self.find_function_calls(parent):
            for result in self.evaluate(call.args[location]):
              yield result
        elif kind == 'var':
          yield tuple
        elif kind == 'kw':
          yield dict
        else:
          assert False

  def find_function_calls(self, node):
    ''' Yield the function/method calls that might be related to a node. '''
    assert isinstance(node, ast.FunctionDef)
    for n in ast.walk(self.tree):
      if isinstance(n, ast.Call) and self.call_to_name(n) == node.name:
        yield n

  def find_function_definitions(self, node):
    ''' Yield the function definitions that might be related to a node. '''
    assert isinstance(node, ast.Call)
    name = self.call_to_name(node)
    for n in ast.walk(self.tree):
      if isinstance(n, ast.FunctionDef) and n.name == name:
        yield n

  def call_to_name(self, node):
    ''' Translate a call to a function/method name. '''
    assert isinstance(node, ast.Call)
    if isinstance(node.func, ast.Name):
      return node.func.id
    elif isinstance(node.func, ast.Attribute):
      return node.func.attr
    else:
      assert False

  def resolve(self, node):
    ''' Resolve an ast.Name node to its definition(s). '''
    # TODO Class and function definitions are assignments as well!
    # TODO Import statements are assignments as well!
    sources = set()
    assert isinstance(node, ast.Name)
    for parent in self.get_parents(node):
      # Search for variable assignments in the current scope?
      if isinstance(parent, (ast.Module, ast.FunctionDef)):
        for n in ast.walk(parent):
          if isinstance(n, ast.Assign):
            for i, target in enumerate(self.flatten(n.targets, [])):
              if target.id == node.id:
                sources.add((n, 'asn', i))
      # Search function arguments?
      if isinstance(parent, ast.FunctionDef):
        # Check the named positional arguments.
        for i, argument in enumerate(parent.args.args):
          if argument.id == node.id:
            sources.add((parent, 'pos', i))
        # Check the tuple with other positional arguments.
        if parent.args.vararg and parent.args.vararg.id == node.id:
          sources.add((parent, 'var', parent.args.vararg))
        # Check the dictionary with other keyword arguments.
        if parent.args.kwarg and parent.args.kwarg.id == node.id:
          sources.add(parent, 'kw', parent.args.kwarg)
    return sources

  def flatten(self, nested, flat):
    ''' Squash a nested sequence into a flat list of nodes. '''
    if isinstance(nested, (ast.Tuple, ast.List)):
      for node in nested.elts:
        self.flatten(node, flat)
    elif isinstance(nested, (tuple, list)):
      for node in nested:
        self.flatten(node, flat)
    else:
      flat.append(nested)
    return flat

  ########################
  ## Debugging helpers. ##
  ########################

  def dump(self, node, level=0):
    ''' Print an AST subtree as a multi line indented string. '''
    if isinstance(node, list):
        for n in node:
            self.dump(n, level)
        return
    if not isinstance(node, ast.Expr):
      print '  ' * level + '(' + type(node).__name__ + ') ' + self.format(node)
      level += 1
    for child in self.get_children(node):
      self.dump(child, level)

  def format(self, node):
    ''' Format an AST node as a string. '''
    # Blocks.
    if isinstance(node, ast.Module):
      return 'module'
    elif isinstance(node, ast.ClassDef):
      return 'class ' + node.name
    elif isinstance(node, ast.FunctionDef):
      return 'function ' + node.name
    elif isinstance(node, ast.For):
      return 'for'
    elif isinstance(node, ast.While):
      return 'while'
    elif isinstance(node, ast.If):
      return 'if'
    elif isinstance(node, ast.Pass):
      return 'pass'
    elif isinstance(node, ast.Print):
      return 'print'
    elif isinstance(node, ast.Assign):
      return '%s=%s' % (', '.join(self.format(t) for t in node.targets), self.format(node.value))
    # Expressions.
    elif isinstance(node, ast.Call):
      args = [self.format(a) for a in node.args]
      for keyword in node.keywords:
        args.append(keyword.arg + '=' + self.format(keyword.value))
      if node.starargs:
        args.append('*' + self.format(node.starargs))
      if node.kwargs:
        args.append('**' + self.format(node.kwargs))
      name = self.format(node.func)
      return 'call %s(%s)' % (name, ', '.join(args))
    elif isinstance(node, ast.Tuple):
      elts = ', '.join(self.format(e) for e in node.elts)
      return '(' + elts + ')'
    elif isinstance(node, ast.List):
      elts = ', '.join(self.format(e) for e in node.elts)
      return '[' + elts + ']'
    elif isinstance(node, ast.Dict):
      pairs = []
      for i in xrange(len(node.values)):
        key = self.format(node.keys[i])
        value = self.format(node.values[i])
        pairs.append(key + ': ' + value)
      return '{' + ', '.join(pairs) + '}'
    elif isinstance(node, ast.Name):
      return node.id
    elif isinstance(node, ast.Attribute):
      return self.format(node.value) + '.' + self.format(node.attr)
    elif isinstance(node, ast.Num):
      return str(node.n)
    elif isinstance(node, ast.Str):
      return "'%s'" % node.s
    elif isinstance(node, ast.Expr):
      return self.format(node.value)
    elif isinstance(node, (str, unicode)):
      return node
    elif isinstance(node, collections.Iterable):
      values = ', '.join(self.format(v) for v in node)
      if isinstance(node, tuple): values = '(%s)' % values
      if isinstance(node, list): values = '[%s]' % values
      return values
    else:
      return str(node)
