" runtime syntax/groovy.vim
syn keyword jenkinsfileBuiltInVariable currentBuild

syn keyword jenkinsfileSection pipeline
syn keyword jenkinsfileSection stages
syn keyword jenkinsfileSection agent
syn keyword jenkinsfileSection post
syn keyword jenkinsfileSection steps

syn keyword jenkinsfileDirective environment
syn keyword jenkinsfileDirective options
syn keyword jenkinsfileDirective parameters
syn keyword jenkinsfileDirective triggers
syn keyword jenkinsfileDirective stage
syn keyword jenkinsfileDirective tools
syn keyword jenkinsfileDirective when

syn keyword jenkinsfileCoreStep checkout
syn keyword jenkinsfileCoreStep node
syn keyword jenkinsfileCoreStep scm
syn keyword jenkinsfileCoreStep sh
syn keyword jenkinsfileCoreStep step
syn keyword jenkinsfileCoreStep tool
syn keyword jenkinsfileCoreStep script
syn keyword jenkinsfileCoreStep mail

syn keyword jenkinsfilePluginStep docker
syn keyword jenkinsfilePluginStep emailext
syn keyword jenkinsfilePluginStep exwsAllocate
syn keyword jenkinsfilePluginStep exws
syn keyword jenkinsfilePluginStep httpRequest
syn keyword jenkinsfilePluginStep junit

hi link jenkinsfileSection Keyword
hi link jenkinsfileDirective Keyword
hi link jenkinsfileCoreStep Function
hi link jenkinsfilePluginStep Include
hi link jenkinsfileBuiltInVariable Identifier


" ##########################
" Java stuff taken from java.vim
" some characters that cannot be in a groovy program (outside a string)
" syn match groovyError "[\\@`]"
"syn match groovyError "<<<\|\.\.\|=>\|<>\|||=\|&&=\|[^-]->\|\*\/"
"syn match groovyOK "\.\.\."

" keyword definitions
syn keyword groovyExternal        native package
syn match groovyExternal          "\<import\>\(\s\+static\>\)\?"
syn keyword groovyError           goto const
syn keyword groovyConditional     if else switch
syn keyword groovyRepeat          while for do
syn keyword groovyBoolean         true false
syn keyword groovyConstant        null
syn keyword groovyTypedef         this super
syn keyword groovyOperator        new instanceof
syn keyword groovyType            boolean char byte short int long float double
syn keyword groovyType            void
syn keyword groovyType		  Integer Double Date Boolean Float String Array Vector List
syn keyword groovyStatement       return
syn keyword groovyStorageClass    static synchronized transient volatile final strictfp serializable
syn keyword groovyExceptions      throw try catch finally
syn keyword groovyAssert          assert
syn keyword groovyMethodDecl      synchronized throws
syn keyword groovyClassDecl       extends implements interface
" to differentiate the keyword class from MyClass.class we use a match here
syn match   groovyTypedef         "\.\s*\<class\>"ms=s+1
syn keyword groovyClassDecl         enum
syn match   groovyClassDecl       "^class\>"
syn match   groovyClassDecl       "[^.]\s*\<class\>"ms=s+1
syn keyword groovyBranch          break continue nextgroup=groovyUserLabelRef skipwhite
syn match   groovyUserLabelRef    "\k\+" contained
syn keyword groovyScopeDecl       public protected private abstract


if exists("groovy_highlight_groovy_lang_ids") || exists("groovy_highlight_groovy_lang") || exists("groovy_highlight_all")
  " groovy.lang.*
  syn keyword groovyLangClass  Closure MetaMethod GroovyObject

  syn match groovyJavaLangClass "\<System\>"
  syn keyword groovyJavaLangClass  Cloneable Comparable Runnable Serializable Boolean Byte Class Object
  syn keyword groovyJavaLangClass  Character CharSequence ClassLoader Compiler
  " syn keyword groovyJavaLangClass  Integer Double Float Long
  syn keyword groovyJavaLangClass  InheritableThreadLocal Math Number Object Package Process
  syn keyword groovyJavaLangClass  Runtime RuntimePermission InheritableThreadLocal
  syn keyword groovyJavaLangClass  SecurityManager Short StrictMath StackTraceElement
  syn keyword groovyJavaLangClass  StringBuffer Thread ThreadGroup
  syn keyword groovyJavaLangClass  ThreadLocal Throwable Void ArithmeticException
  syn keyword groovyJavaLangClass  ArrayIndexOutOfBoundsException AssertionError
  syn keyword groovyJavaLangClass  ArrayStoreException ClassCastException
  syn keyword groovyJavaLangClass  ClassNotFoundException
  syn keyword groovyJavaLangClass  CloneNotSupportedException Exception
  syn keyword groovyJavaLangClass  IllegalAccessException
  syn keyword groovyJavaLangClass  IllegalArgumentException
  syn keyword groovyJavaLangClass  IllegalMonitorStateException
  syn keyword groovyJavaLangClass  IllegalStateException
  syn keyword groovyJavaLangClass  IllegalThreadStateException
  syn keyword groovyJavaLangClass  IndexOutOfBoundsException
  syn keyword groovyJavaLangClass  InstantiationException InterruptedException
  syn keyword groovyJavaLangClass  NegativeArraySizeException NoSuchFieldException
  syn keyword groovyJavaLangClass  NoSuchMethodException NullPointerException
  syn keyword groovyJavaLangClass  NumberFormatException RuntimeException
  syn keyword groovyJavaLangClass  SecurityException StringIndexOutOfBoundsException
  syn keyword groovyJavaLangClass  UnsupportedOperationException
  syn keyword groovyJavaLangClass  AbstractMethodError ClassCircularityError
  syn keyword groovyJavaLangClass  ClassFormatError Error ExceptionInInitializerError
  syn keyword groovyJavaLangClass  IllegalAccessError InstantiationError
  syn keyword groovyJavaLangClass  IncompatibleClassChangeError InternalError
  syn keyword groovyJavaLangClass  LinkageError NoClassDefFoundError
  syn keyword groovyJavaLangClass  NoSuchFieldError NoSuchMethodError
  syn keyword groovyJavaLangClass  OutOfMemoryError StackOverflowError
  syn keyword groovyJavaLangClass  ThreadDeath UnknownError UnsatisfiedLinkError
  syn keyword groovyJavaLangClass  UnsupportedClassVersionError VerifyError
  syn keyword groovyJavaLangClass  VirtualMachineError

  syn keyword groovyJavaLangObject clone equals finalize getClass hashCode
  syn keyword groovyJavaLangObject notify notifyAll toString wait

  hi def link groovyLangClass                   groovyConstant
  hi def link groovyJavaLangClass               groovyExternal
  hi def link groovyJavaLangObject              groovyConstant
  syn cluster groovyTop add=groovyJavaLangObject,groovyJavaLangClass,groovyLangClass
  syn cluster groovyClasses add=groovyJavaLangClass,groovyLangClass
endif


" Groovy stuff
syn match groovyOperator "\.\."
syn match groovyOperator "<\{2,3}"
syn match groovyOperator ">\{2,3}"
syn match groovyOperator "->"
syn match groovyLineComment       '^\%1l#!.*'  " Shebang line
syn match groovyExceptions        "\<Exception\>\|\<[A-Z]\{1,}[a-zA-Z0-9]*Exception\>"

" Groovy JDK stuff
syn keyword groovyJDKBuiltin    as def in
syn keyword groovyJDKOperOverl  div minus plus abs round power multiply
syn keyword groovyJDKMethods 	each call inject sort print println
syn keyword groovyJDKMethods    getAt putAt size push pop toList getText writeLine eachLine readLines
syn keyword groovyJDKMethods    withReader withStream withWriter withPrintWriter write read leftShift
syn keyword groovyJDKMethods    withWriterAppend readBytes splitEachLine
syn keyword groovyJDKMethods    newInputStream newOutputStream newPrintWriter newReader newWriter
syn keyword groovyJDKMethods    compareTo next previous isCase
syn keyword groovyJDKMethods    times step toInteger upto any collect dump every find findAll grep
syn keyword groovyJDKMethods    inspect invokeMethods join
syn keyword groovyJDKMethods    getErr getIn getOut waitForOrKill
syn keyword groovyJDKMethods    count tokenize asList flatten immutable intersect reverse reverseEach
syn keyword groovyJDKMethods    subMap append asWritable eachByte eachLine eachFile
syn cluster groovyTop add=groovyJDKBuiltin,groovyJDKOperOverl,groovyJDKMethods

" no useful I think, so I comment it..
"if filereadable(expand("<sfile>:p:h")."/groovyid.vim")
 " source <sfile>:p:h/groovyid.vim
"endif

" it is a better case construct than java.vim to match groovy syntax
syn region  groovyLabelRegion     transparent matchgroup=groovyLabel start="\<case\>" matchgroup=NONE end=":\|$" contains=groovyNumber,groovyString,groovyLangClass,groovyJavaLangClass
syn match   groovyUserLabel       "^\s*[_$a-zA-Z][_$a-zA-Z0-9_]*\s*:"he=e-1 contains=groovyLabel
syn keyword groovyLabel           default

" The following cluster contains all groovy groups except the contained ones
syn cluster groovyTop add=groovyExternal,groovyError,groovyError,groovyBranch,groovyLabelRegion,groovyLabel,groovyConditional,groovyRepeat,groovyBoolean,groovyConstant,groovyTypedef,groovyOperator,groovyType,groovyType,groovyStatement,groovyStorageClass,groovyAssert,groovyExceptions,groovyMethodDecl,groovyClassDecl,groovyClassDecl,groovyClassDecl,groovyScopeDecl,groovyError,groovyError2,groovyUserLabel,groovyLangObject


" Comments
syn keyword groovyTodo             contained TODO FIXME XXX
if exists("groovy_comment_strings")
  syn region  groovyCommentString    contained start=+"+ end=+"+ end=+$+ end=+\*/+me=s-1,he=s-1 contains=groovySpecial,groovyCommentStar,groovySpecialChar,@Spell
  syn region  groovyComment2String   contained start=+"+  end=+$\|"+  contains=groovySpecial,groovySpecialChar,@Spell
  syn match   groovyCommentCharacter contained "'\\[^']\{1,6\}'" contains=groovySpecialChar
  syn match   groovyCommentCharacter contained "'\\''" contains=groovySpecialChar
  syn match   groovyCommentCharacter contained "'[^\\]'"
  syn cluster groovyCommentSpecial add=groovyCommentString,groovyCommentCharacter,groovyNumber
  syn cluster groovyCommentSpecial2 add=groovyComment2String,groovyCommentCharacter,groovyNumber
endif
syn region  groovyComment          start="/\*"  end="\*/" contains=@groovyCommentSpecial,groovyTodo,@Spell
syn match   groovyCommentStar      contained "^\s*\*[^/]"me=e-1
syn match   groovyCommentStar      contained "^\s*\*$"
syn match   groovyLineComment      "//.*" contains=@groovyCommentSpecial2,groovyTodo,@Spell
hi def link groovyCommentString groovyString
hi def link groovyComment2String groovyString
hi def link groovyCommentCharacter groovyCharacter

syn cluster groovyTop add=groovyComment,groovyLineComment

" match the special comment /**/
syn match   groovyComment          "/\*\*/"

" Strings and constants
syn match   groovySpecialError     contained "\\."
syn match   groovySpecialCharError contained "[^']"
syn match   groovySpecialChar      contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\|\$\)"
syn match   groovyRegexChar        contained "\\."
syn region  groovyString          start=+"+ end=+"+ end=+$+ contains=groovySpecialChar,groovySpecialError,@Spell,groovyELExpr
syn region  groovyString          start=+'+ end=+'+ end=+$+ contains=groovySpecialChar,groovySpecialError,@Spell
syn region  groovyString          start=+"""+ end=+"""+ contains=groovySpecialChar,groovySpecialError,@Spell,groovyELExpr
syn region  groovyString          start=+'''+ end=+'''+ contains=groovySpecialChar,groovySpecialError,@Spell

" syn region groovyELExpr start=+${+ end=+}+ keepend contained
syn match groovyELExpr /\${.\{-}}/ contained
syn match groovyELExpr /\$[a-zA-Z_][a-zA-Z0-9_.]*/ contained
hi def link groovyELExpr Identifier

" TODO: better matching. I am waiting to understand how it really works in groovy
" syn region  groovyClosureParamsBraces          start=+|+ end=+|+ contains=groovyClosureParams
" syn match groovyClosureParams	"[ a-zA-Z0-9_*]\+" contained
" hi def link groovyClosureParams Identifier

" next line disabled, it can cause a crash for a long line
"syn match   groovyStringError      +"\([^"\\]\|\\.\)*$+

" disabled: in groovy strings or characters are written the same
" syn match   groovyCharacter        "'[^']*'" contains=groovySpecialChar,groovySpecialCharError
" syn match   groovyCharacter        "'\\''" contains=groovySpecialChar
" syn match   groovyCharacter        "'[^\\]'"
syn match   groovyNumber           "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   groovyNumber           "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   groovyNumber           "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   groovyNumber           "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" unicode characters
syn match   groovySpecial "\\u\d\{4\}"

syn cluster groovyTop add=groovyString,groovyCharacter,groovyNumber,groovySpecial,groovyStringError

" Match all Exception classes
syn match groovyExceptions        "\<Exception\>\|\<[A-Z]\{1,}[a-zA-Z0-9]*Exception\>"

" ###################
" Groovy stuff
" syn match groovyOperator		"|[ ,a-zA-Z0-9_*]\+|"

" All groovy valid tokens
" syn match groovyTokens ";\|,\|<=>\|<>\|:\|:=\|>\|>=\|=\|==\|<\|<=\|!=\|/\|/=\|\.\.|\.\.\.\|\~=\|\~=="
" syn match groovyTokens "\*=\|&\|&=\|\*\|->\|\~\|+\|-\|/\|?\|<<<\|>>>\|<<\|>>"

" Must put explicit these ones because groovy.vim mark them as errors otherwise
" syn match groovyTokens "<=>\|<>\|==\~"
"syn cluster groovyTop add=groovyTokens

" Mark these as operators

" Hightlight brackets
" syn match  groovyBraces		"[{}]"
" syn match  groovyBraces		"[\[\]]"
" syn match  groovyBraces		"[\|]"

" catch errors caused by wrong parenthesis
syn region  groovyParenT  transparent matchgroup=groovyParen  start="("  end=")" contains=@groovyTop,groovyParenT1
syn region  groovyParenT1 transparent matchgroup=groovyParen1 start="(" end=")" contains=@groovyTop,groovyParenT2 contained
syn region  groovyParenT2 transparent matchgroup=groovyParen2 start="(" end=")" contains=@groovyTop,groovyParenT  contained
syn match   groovyParenError       ")"
hi def link groovyParenError       groovyError

" catch errors caused by wrong square parenthesis
syn region  groovyParenT  transparent matchgroup=groovyParen  start="\["  end="\]" contains=@groovyTop,groovyParenT1
syn region  groovyParenT1 transparent matchgroup=groovyParen1 start="\[" end="\]" contains=@groovyTop,groovyParenT2 contained
syn region  groovyParenT2 transparent matchgroup=groovyParen2 start="\[" end="\]" contains=@groovyTop,groovyParenT  contained
syn match   groovyParenError       "\]"

" ###############################
" java.vim default highlighting
hi def link groovyFuncDef		Function
hi def link groovyBraces		Function
hi def link groovyBranch		Conditional
hi def link groovyUserLabelRef	groovyUserLabel
hi def link groovyLabel		Label
hi def link groovyUserLabel		Label
hi def link groovyConditional	Conditional
hi def link groovyRepeat		Repeat
hi def link groovyExceptions		Exception
hi def link groovyAssert 		Statement
hi def link groovyStorageClass	StorageClass
hi def link groovyMethodDecl		groovyStorageClass
hi def link groovyClassDecl		groovyStorageClass
hi def link groovyScopeDecl		groovyStorageClass
hi def link groovyBoolean		Boolean
hi def link groovySpecial		Special
hi def link groovySpecialError	Error
hi def link groovySpecialCharError	Error
hi def link groovyString		String
hi def link groovyRegexChar		String
hi def link groovyCharacter		Character
hi def link groovySpecialChar	SpecialChar
hi def link groovyNumber		Number
hi def link groovyError		Error
hi def link groovyStringError	Error
hi def link groovyStatement		Statement
hi def link groovyOperator		Operator
hi def link groovyComment		Comment
hi def link groovyDocComment		Comment
hi def link groovyLineComment	Comment
hi def link groovyConstant		Constant
hi def link groovyTypedef		Typedef
hi def link groovyTodo		Todo

hi def link groovyCommentTitle	SpecialComment
hi def link groovyDocTags		Special
hi def link groovyDocParam		Function
hi def link groovyCommentStar	groovyComment

hi def link groovyType		Type
hi def link groovyExternal		Include

hi def link htmlComment		Special
hi def link htmlCommentPart		Special
hi def link groovySpaceError		Error
hi def link groovyJDKBuiltin         Special
hi def link groovyJDKOperOverl       Operator
hi def link groovyJDKMethods         Function

let b:current_syntax = "Jenkinsfile"
