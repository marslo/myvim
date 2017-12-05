runtime syntax/groovy.vim
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

let b:current_syntax = "Jenkinsfile"
