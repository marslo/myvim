require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "bash", "groovy", "java", "yaml", "xml", "cmake", "css", "dockerfile", "git_config", "gitcommit", "gitignore", "jq", "json", "markdown", "ssh_config" },
  sync_install = true,
  auto_install = true,
  ignore_install = { "javascript" },
  indent = {
    enable = true,
    disable = { "markdown" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  highlight = {
    enable = true,
    disable = { "markdown" },
    additional_vim_regex_highlighting = false,
  },
}
require("nvim-treesitter.install").prefer_git = true

