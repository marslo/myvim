local remap = vim.api.nvim_set_keymap

vim.o.completeopt = "menuone,noselect,preview"

-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  -- Pictograms
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
      return vim_item
    end,
  },
})

-- Snippets
local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local luasnip = prequire("luasnip")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  elseif luasnip and luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  else
    return t("<S-Tab>")
  end
end

-- Remaps
remap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
remap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
remap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
remap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
remap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
remap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- Snippets
require("luasnip/loaders/from_vscode").lazy_load({
  paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
})
