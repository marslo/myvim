require 'colorizer'.setup()
require 'colorizer'.setup {
  filetypes = {
    '*';
    css = { rgb_fn = true; mode = 'background'; };
    html = { names = true; };
    cmp_docs = {always_update = true}
  },
  user_default_options = { RRGGBBAA = true, css_fn = true, css = true, tailwind = true },
  buftypes = { "*", "!prompt", "!popup", }
}
