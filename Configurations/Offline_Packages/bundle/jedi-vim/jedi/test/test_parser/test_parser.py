# -*- coding: utf-8 -*-
import sys
from textwrap import dedent

import jedi
from jedi._compatibility import u, is_py3
from jedi.parser import ParserWithRecovery, load_grammar
from jedi.parser import tree as pt


def test_user_statement_on_import():
    """github #285"""
    s = u("from datetime import (\n"
          "    time)")

    for pos in [(2, 1), (2, 4)]:
        p = ParserWithRecovery(load_grammar(), s)
        stmt = p.module.get_statement_for_position(pos)
        assert isinstance(stmt, pt.Import)
        assert [str(n) for n in stmt.get_defined_names()] == ['time']


class TestCallAndName():
    def get_call(self, source):
        # Get the simple_stmt and then the first one.
        simple_stmt = ParserWithRecovery(load_grammar(), u(source)).module.children[0]
        return simple_stmt.children[0]

    def test_name_and_call_positions(self):
        name = self.get_call('name\nsomething_else')
        assert str(name) == 'name'
        assert name.start_pos == (1, 0)
        assert name.end_pos == (1, 4)

        leaf = self.get_call('1.0\n')
        assert leaf.value == '1.0'
        assert leaf.eval() == 1.0
        assert leaf.start_pos == (1, 0)
        assert leaf.end_pos == (1, 3)

    def test_call_type(self):
        call = self.get_call('hello')
        assert isinstance(call, pt.Name)

    def test_literal_type(self):
        literal = self.get_call('1.0')
        assert isinstance(literal, pt.Literal)
        assert type(literal.eval()) == float

        literal = self.get_call('1')
        assert isinstance(literal, pt.Literal)
        assert type(literal.eval()) == int

        literal = self.get_call('"hello"')
        assert isinstance(literal, pt.Literal)
        assert literal.eval() == 'hello'


class TestSubscopes():
    def get_sub(self, source):
        return ParserWithRecovery(load_grammar(), u(source)).module.subscopes[0]

    def test_subscope_names(self):
        name = self.get_sub('class Foo: pass').name
        assert name.start_pos == (1, len('class '))
        assert name.end_pos == (1, len('class Foo'))
        assert str(name) == 'Foo'

        name = self.get_sub('def foo(): pass').name
        assert name.start_pos == (1, len('def '))
        assert name.end_pos == (1, len('def foo'))
        assert str(name) == 'foo'


class TestImports():
    def get_import(self, source):
        return ParserWithRecovery(load_grammar(), source).module.imports[0]

    def test_import_names(self):
        imp = self.get_import(u('import math\n'))
        names = imp.get_defined_names()
        assert len(names) == 1
        assert str(names[0]) == 'math'
        assert names[0].start_pos == (1, len('import '))
        assert names[0].end_pos == (1, len('import math'))

        assert imp.start_pos == (1, 0)
        assert imp.end_pos == (1, len('import math'))


def test_module():
    module = ParserWithRecovery(load_grammar(), u('asdf'), 'example.py').module
    name = module.name
    assert str(name) == 'example'
    assert name.start_pos == (1, 0)
    assert name.end_pos == (1, 7)

    module = ParserWithRecovery(load_grammar(), u('asdf')).module
    name = module.name
    assert str(name) == ''
    assert name.start_pos == (1, 0)
    assert name.end_pos == (1, 0)


def test_end_pos():
    s = u(dedent('''
                 x = ['a', 'b', 'c']
                 def func():
                     y = None
                 '''))
    parser = ParserWithRecovery(load_grammar(), s)
    scope = parser.module.subscopes[0]
    assert scope.start_pos == (3, 0)
    assert scope.end_pos == (5, 0)


def test_carriage_return_statements():
    source = u(dedent('''
        foo = 'ns1!'

        # this is a namespace package
    '''))
    source = source.replace('\n', '\r\n')
    stmt = ParserWithRecovery(load_grammar(), source).module.statements[0]
    assert '#' not in stmt.get_code()


def test_incomplete_list_comprehension():
    """ Shouldn't raise an error, same bug as #418. """
    # With the old parser this actually returned a statement. With the new
    # parser only valid statements generate one.
    assert ParserWithRecovery(load_grammar(), u('(1 for def')).module.statements == []


def test_hex_values_in_docstring():
    source = r'''
        def foo(object):
            """
             \xff
            """
            return 1
        '''

    doc = ParserWithRecovery(load_grammar(), dedent(u(source))).module.subscopes[0].raw_doc
    if is_py3:
        assert doc == '\xff'
    else:
        assert doc == u('�')


def test_error_correction_with():
    source = """
    with open() as f:
        try:
            f."""
    comps = jedi.Script(source).completions()
    assert len(comps) > 30
    # `open` completions have a closed attribute.
    assert [1 for c in comps if c.name == 'closed']


def test_newline_positions():
    endmarker = ParserWithRecovery(load_grammar(), u('a\n')).module.children[-1]
    assert endmarker.end_pos == (2, 0)
    new_line = endmarker.get_previous_leaf()
    assert new_line.start_pos == (1, 1)
    assert new_line.end_pos == (2, 0)


def test_end_pos_error_correction():
    """
    Source code without ending newline are given one, because the Python
    grammar needs it. However, they are removed again. We still want the right
    end_pos, even if something breaks in the parser (error correction).
    """
    s = u('def x():\n .')
    m = ParserWithRecovery(load_grammar(), s).module
    func = m.children[0]
    assert func.type == 'funcdef'
    assert func.end_pos == (2, 2)
    assert m.end_pos == (2, 2)


def test_param_splitting():
    """
    Jedi splits parameters into params, this is not what the grammar does,
    but Jedi does this to simplify argument parsing.
    """
    def check(src, result):
        # Python 2 tuple params should be ignored for now.
        grammar = load_grammar('%s.%s' % sys.version_info[:2])
        m = ParserWithRecovery(grammar, u(src)).module
        if is_py3:
            assert not m.subscopes
        else:
            # We don't want b and c to be a part of the param enumeration. Just
            # ignore them, because it's not what we want to support in the
            # future.
            assert [str(param.name) for param in m.subscopes[0].params] == result

    check('def x(a, (b, c)):\n pass', ['a'])
    check('def x((b, c)):\n pass', [])


def test_unicode_string():
    s = pt.String(None, u('bö'), (0, 0))
    assert repr(s)  # Should not raise an Error!


def test_backslash_dos_style():
    grammar = load_grammar()
    m = ParserWithRecovery(grammar, u('\\\r\n')).module
    assert m


def test_started_lambda_stmt():
    p = ParserWithRecovery(load_grammar(), u'lambda a, b: a i')
    assert p.get_parsed_node().children[0].type == 'error_node'


def test_python2_octal():
    parser = ParserWithRecovery(load_grammar(), u'0660')
    first = parser.get_parsed_node().children[0]
    if is_py3:
        assert first.type == 'error_node'
    else:
        assert first.children[0].type == 'number'


def test_python3_octal():
    parser = ParserWithRecovery(load_grammar(), u'0o660')
    module = parser.get_parsed_node()
    if is_py3:
        assert module.children[0].children[0].type == 'number'
    else:
        assert module.children[0].type == 'error_node'


def test_load_newer_grammar():
    # This version shouldn't be out for a while, but if we somehow get this it
    # should just take the latest Python grammar.
    load_grammar('15.8')
    # The same is true for very old grammars (even though this is probably not
    # going to be an issue.
    load_grammar('1.5')
