local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>',         api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',             api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', '<leader>hh',     api.node.open.horizontal)
  vim.keymap.set('n', '<leader>vv',     api.node.open.vertical)

end


-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  sync_root_with_cwd = false,
  on_attach = my_on_attach,
  ---
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
}
