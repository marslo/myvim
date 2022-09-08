# Stubs for operator

from typing import (
    Any, Callable, Container, Mapping, MutableMapping, MutableSequence, Sequence, SupportsAbs, Tuple,
    TypeVar, overload,
)
import sys


_T = TypeVar('_T')
_K = TypeVar('_K')
_V = TypeVar('_V')


def lt(a: Any, b: Any) -> Any: ...
def le(a: Any, b: Any) -> Any: ...
def eq(a: Any, b: Any) -> Any: ...
def ne(a: Any, b: Any) -> Any: ...
def ge(a: Any, b: Any) -> Any: ...
def gt(a: Any, b: Any) -> Any: ...
def __lt__(a: Any, b: Any) -> Any: ...
def __le__(a: Any, b: Any) -> Any: ...
def __eq__(a: Any, b: Any) -> Any: ...
def __ne__(a: Any, b: Any) -> Any: ...
def __ge__(a: Any, b: Any) -> Any: ...
def __gt__(a: Any, b: Any) -> Any: ...

def not_(obj: Any) -> bool: ...
def __not__(obj: Any) -> bool: ...

def truth(x: Any) -> bool: ...

def is_(a: Any, b: Any) -> bool: ...

def is_not(a: Any, b: Any) -> bool: ...

def abs(x: SupportsAbs) -> Any: ...
def __abs__(a: SupportsAbs) -> Any: ...

def add(a: Any, b: Any) -> Any: ...
def __add__(a: Any, b: Any) -> Any: ...

def and_(a: Any, b: Any) -> Any: ...
def __and__(a: Any, b: Any) -> Any: ...

if sys.version_info < (3, ):
    def div(a: Any, b: Any) -> Any: ...
    def __div__(a: Any, b: Any) -> Any: ...

def floordiv(a: Any, b: Any) -> Any: ...
def __floordiv__(a: Any, b: Any) -> Any: ...

def index(a: Any) -> int: ...
def __index__(a: Any) -> int: ...

def inv(obj: Any) -> Any: ...
def invert(obj: Any) -> Any: ...
def __inv__(obj: Any) -> Any: ...
def __invert__(obj: Any) -> Any: ...

def lshift(a: Any, b: Any) -> Any: ...
def __lshift__(a: Any, b: Any) -> Any: ...

def mod(a: Any, b: Any) -> Any: ...
def __mod__(a: Any, b: Any) -> Any: ...

def mul(a: Any, b: Any) -> Any: ...
def __mul__(a: Any, b: Any) -> Any: ...

if sys.version_info >= (3, 5):
    def matmul(a: Any, b: Any) -> Any: ...
    def __matmul__(a: Any, b: Any) -> Any: ...

def neg(obj: Any) -> Any: ...
def __neg__(obj: Any) -> Any: ...

def or_(a: Any, b: Any) -> Any: ...
def __or__(a: Any, b: Any) -> Any: ...

def pos(obj: Any) -> Any: ...
def __pos__(obj: Any) -> Any: ...

def pow(a: Any, b: Any) -> Any: ...
def __pow__(a: Any, b: Any) -> Any: ...

def rshift(a: Any, b: Any) -> Any: ...
def __rshift__(a: Any, b: Any) -> Any: ...

def sub(a: Any, b: Any) -> Any: ...
def __sub__(a: Any, b: Any) -> Any: ...

def truediv(a: Any, b: Any) -> Any: ...
def __truediv__(a: Any, b: Any) -> Any: ...

def xor(a: Any, b: Any) -> Any: ...
def __xor__(a: Any, b: Any) -> Any: ...

def concat(a: Sequence[_T], b: Sequence[_T]) -> Sequence[_T]: ...
def __concat__(a: Sequence[_T], b: Sequence[_T]) -> Sequence[_T]: ...

def contains(a: Container[Any], b: Any) -> bool: ...
def __contains__(a: Container[Any], b: Any) -> bool: ...

def countOf(a: Container[Any], b: Any) -> int: ...

@overload
def delitem(a: MutableSequence[_T], b: int) -> None: ...
@overload
def delitem(a: MutableMapping[_K, _V], b: _K) -> None: ...
@overload
def __delitem__(a: MutableSequence[_T], b: int) -> None: ...
@overload
def __delitem__(a: MutableMapping[_K, _V], b: _K) -> None: ...

if sys.version_info < (3, ):
    def delslice(a: MutableSequence[Any], b: int, c: int) -> None: ...
    def __delslice__(a: MutableSequence[Any], b: int, c: int) -> None: ...

@overload
def getitem(a: Sequence[_T], b: int) -> _T: ...
@overload
def getitem(a: Mapping[_K, _V], b: _K) -> _V: ...
@overload
def __getitem__(a: Sequence[_T], b: int) -> _T: ...
@overload
def __getitem__(a: Mapping[_K, _V], b: _K) -> _V: ...

if sys.version_info < (3, ):
    def getslice(a: Sequence[_T], b: int, c: int) -> Sequence[_T]: ...
    def __getslice__(a: Sequence[_T], b: int, c: int) -> Sequence[_T]: ...

def indexOf(a: Sequence[_T], b: _T) -> int: ...

if sys.version_info < (3, ):
    def repeat(a: Any, b: int) -> Any: ...
    def __repeat__(a: Any, b: int) -> Any: ...

if sys.version_info < (3, ):
    def sequenceIncludes(a: Container[Any], b: Any) -> bool: ...

@overload
def setitem(a: MutableSequence[_T], b: int, c: _T) -> None: ...
@overload
def setitem(a: MutableMapping[_K, _V], b: _K, c: _V) -> None: ...
@overload
def __setitem__(a: MutableSequence[_T], b: int, c: _T) -> None: ...
@overload
def __setitem__(a: MutableMapping[_K, _V], b: _K, c: _V) -> None: ...

if sys.version_info < (3, ):
    def setslice(a: MutableSequence[_T], b: int, c: int, v: Sequence[_T]) -> None: ...
    def __setslice__(a: MutableSequence[_T], b: int, c: int, v: Sequence[_T]) -> None: ...


if sys.version_info >= (3, 4):
    def length_hint(obj: Any, default: int = ...) -> int: ...

@overload
def attrgetter(attr: str) -> Callable[[Any], Any]: ...
@overload
def attrgetter(*attrs: str) -> Callable[[Any], Tuple[Any, ...]]: ...

@overload
def itemgetter(item: Any) -> Callable[[Any], Any]: ...
@overload
def itemgetter(*items: Any) -> Callable[[Any], Tuple[Any, ...]]: ...

def methodcaller(name: str, *args: Any, **kwargs: Any) -> Callable[..., Any]: ...


def iadd(a: Any, b: Any) -> Any: ...
def __iadd__(a: Any, b: Any) -> Any: ...

def iand(a: Any, b: Any) -> Any: ...
def __iand__(a: Any, b: Any) -> Any: ...

def iconcat(a: Any, b: Any) -> Any: ...
def __iconcat__(a: Any, b: Any) -> Any: ...

if sys.version_info < (3, ):
    def idiv(a: Any, b: Any) -> Any: ...
    def __idiv__(a: Any, b: Any) -> Any: ...

def ifloordiv(a: Any, b: Any) -> Any: ...
def __ifloordiv__(a: Any, b: Any) -> Any: ...

def ilshift(a: Any, b: Any) -> Any: ...
def __ilshift__(a: Any, b: Any) -> Any: ...

def imod(a: Any, b: Any) -> Any: ...
def __imod__(a: Any, b: Any) -> Any: ...

def imul(a: Any, b: Any) -> Any: ...
def __imul__(a: Any, b: Any) -> Any: ...

if sys.version_info >= (3, 5):
    def imatmul(a: Any, b: Any) -> Any: ...
    def __imatmul__(a: Any, b: Any) -> Any: ...

def ior(a: Any, b: Any) -> Any: ...
def __ior__(a: Any, b: Any) -> Any: ...

def ipow(a: Any, b: Any) -> Any: ...
def __ipow__(a: Any, b: Any) -> Any: ...

if sys.version_info < (3, ):
    def irepeat(a: Any, b: int) -> Any: ...
    def __irepeat__(a: Any, b: int) -> Any: ...

def irshift(a: Any, b: Any) -> Any: ...
def __irshift__(a: Any, b: Any) -> Any: ...

def isub(a: Any, b: Any) -> Any: ...
def __isub__(a: Any, b: Any) -> Any: ...

def itruediv(a: Any, b: Any) -> Any: ...
def __itruediv__(a: Any, b: Any) -> Any: ...

def ixor(a: Any, b: Any) -> Any: ...
def __ixor__(a: Any, b: Any) -> Any: ...


if sys.version_info < (3, ):
    def isCallable(x: Any) -> bool: ...
    def isMappingType(x: Any) -> bool: ...
    def isNumberType(x: Any) -> bool: ...
    def isSequenceType(x: Any) -> bool: ...
