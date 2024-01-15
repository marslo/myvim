vim.cmd( 'set runtimepath^=~/.vim runtimepath+=~/.vim/after' )
vim.cmd( 'let &packpath = &runtimepath' )
vim.cmd( 'source ~/.vimrc' )
vim.cmd( 'autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}' )

-- coc.nvim
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- require('config/theme')
require('config/nvim-treesitter')
require('config/lsp')
