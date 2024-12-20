require('neodev').setup()

local lspconfig = require('lspconfig')
lspconfig.nil_ls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.shopify_theme_ls.setup({})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

