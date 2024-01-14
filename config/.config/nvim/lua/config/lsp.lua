--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup { capabilities = capabilities, }
require'lspconfig'.cssls.setup{}

require'lspconfig'.html.setup { capabilities = capabilities, }
require'lspconfig'.html.setup {}

require'lspconfig'.jsonls.setup { capabilities = capabilities, }
require'lspconfig'.jsonls.setup {}

require'lspconfig'.pyright.setup{}
require'lspconfig'.ansiblels.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gradle_ls.setup{}
require'lspconfig'.groovyls.setup{
  filetypes = { 'groovy', 'Jenkinsfile' },
  cmd = { "java", "-jar", "~/.vim/plugged/lsp-examples/groovy/groovy-language-server/build/libs/groovy-language-server-all.jar" },
}
