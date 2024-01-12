from inference import TypeInferenceEngine

def resolve_simplified(tie, node):
  nodes = []
  for parent, kind, context in tie.resolve(node):
    nodes.append(tie.format(parent))
  return nodes

source = open('example.py').read()
tie = TypeInferenceEngine(source)
shadowed_var = tie.find_node(9, 5)
global_var = tie.find_node(10, 12)
kw_indirect = tie.find_node(10, 33)
kw = tie.find_node(10, 46)
init_arg = tie.find_node(11, 9)

def test_resolving():
  assert global_var.id == 'global_var'
  assert kw_indirect.id == 'kw_indirect'
  assert init_arg.id == 'init_arg'
  assert resolve_simplified(tie, global_var) == ['global_var=42']
  assert resolve_simplified(tie, init_arg) == ['function __init__']
  assert resolve_simplified(tie, kw_indirect) == ['function __init__']
  assert sorted(resolve_simplified(tie, shadowed_var)) == sorted(["shadowed=''", "shadowed=[]"])

def test_evaluation():
  assert list(tie.evaluate(global_var)) == [int]
  assert list(tie.evaluate(kw)) == [list]
  assert list(tie.evaluate(kw_indirect)) == [str]
  assert list(tie.evaluate(tie.find_node(37, 1))) == [list]
  assert list(tie.evaluate(tie.find_node(37, 1))) == [list]
  assert list(tie.evaluate(tie.find_node(42, 1))) == [set]
  assert list(tie.evaluate(tie.find_node(42, 4))) == [dict]

def test_completion():
  assert 'conjugate' in tie.complete(1, 1)
  assert 'keys' in tie.complete(42, 4)
  assert 'append' in tie.complete(48, 7) and 'capitalize' in tie.complete(47, 7)
  assert 'difference' in tie.complete(51, 13)
  assert 'test' in tie.complete(22, 13)
