'''
Examples of code for which static analysis (type inference) should be able to
generate good completion candidates. Obviously this test case is only fun when
the completion handling code uses the (work-in-progress) type inference engine.
'''

###########################################################
## Basic completion of built-in types                    ##
###########################################################

value = ""
value.strip() # <- completion of string methods

###########################################################
## Basic completion combined with tuple unpacking        ##
###########################################################

l, d, f = [], {}, file()
l.append() # <- completion of list methods
d.keys() # <- completion of dictionary methods
f.close() # <- completion of file methods

###########################################################
## Type inference of function return values              ##
###########################################################

def foo():
  return ""
foo_rv = foo()
foo_rv.strip() # <- completion of string methods

###########################################################
## Function return values with multiple possible types   ##
###########################################################

def bar(what_will_it_be):
  if what_will_it_be:
    return []
  else:
    return ''
bar_rv = bar(True)
bar_rv.append() # <- completion of list methods
bar_rv.capitalize() # <- completion of string methods

###########################################################
## Type inference of indirect return values              ##
###########################################################

def a(): return []
def b(): return a()
def c(): return b()
def d(): return c()
d_rv = d()
d_rv.append() # <- completion of list methods

###########################################################
## Type inference of references to variables             ##
###########################################################

some_list = []
ref_to_list = some_list
ref_to_list.append() # <- completion of list methods

###########################################################
## Type inference of function arguments                  ##
###########################################################

def foobar(arg):
  arg.strip() # <- completion of string methods

foobar('')
