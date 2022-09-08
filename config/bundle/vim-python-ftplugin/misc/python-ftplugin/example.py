global_var = 42
var1, var2 = 1, 2
some_string = ''
shadowed = ''

class ExampleClass:

  def __init__(self, init_arg, kw=[], kw_indirect=some_string):
    shadowed = []
    print global_var, shadowed, kw_indirect, kw
    if init_arg:
      def fun_inside_if(): pass
    elif 1:
      def fun_inside_elif_1(): pass
    elif 2:
      def fun_inside_elif_2(): pass
    else:
      def fun_inside_else(): pass

  def a(self, example_argument):
    for i in xrange(5):
      print example_argument
    while True:
      def inside_while(): pass

  def b(self):
    def nested():
      print 5
    nested()

ExampleClass.b(normal_arg, kw_arg=5, *(1, 2), **{'key': 42})
ExampleClass.a('')

def newlist():
  return []

l = newlist()

def newmaps():
  return set(), dict()

s, d = newmaps()

if True:
  variant = []
else:
  variant = ''
print variant

def func(blaat):
  print dir(s2)

func(set())
func(list())
