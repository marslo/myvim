'''
Examples of code for which the syntax based folding
support should be able to generate good text folds
(this is one of the lines that will be folded).
'''

# Block
# comment
# on
# multiple
# lines.

foo = 0

def inline(): return 3

def test2():
    pass
    pass
    pass

def test(test):
    """
    This is the
    docstring!
    """
    pass

class Test:

    def foo():
        ''' docstring for foo() '''
        pass

    @foo(bar='foo') # foo needs foo as bar.
    @property
    def bar():
        '''
        docstring for bar()
        '''
        pass

    @property
    def baz(bar='',
            baz=':',
            foo=None):
        '''
        docstring for baz()
        '''
        pass

    def gr():
        pass

