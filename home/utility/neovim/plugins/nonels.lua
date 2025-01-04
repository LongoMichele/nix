local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,

		null_ls.builtins.diagnostics.statix,
		null_ls.builtins.code_actions.statix,
		null_ls.builtins.formatting.nixpkgs_fmt,
	},
})

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
