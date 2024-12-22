return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Formatters
				null_ls.builtins.formatting.stylua, -- Lua formatter
				null_ls.builtins.formatting.prettier.with({
					extra_filetypes = { "json", "yaml", "markdown" },
				}), -- Prettier for JS/TS/HTML/CSS/JSON/MD

				-- Linters
				require("none-ls.diagnostics.eslint_d"), -- Fast ESLint linter
			},
			-- on_attach = function(client, bufnr)
			--   -- Auto-format on save
			--   if client.server_capabilities.documentFormattingProvider then
			--     vim.api.nvim_create_autocmd("BufWritePre", {
			--       buffer = bufnr,
			--       callback = function()
			--         vim.lsp.buf.format({ bufnr = bufnr })
			--       end,
			--     })
			--   end
			-- end,
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format File" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	end,
}
