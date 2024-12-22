return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Ensure parsers are up to date
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { -- Parsers to install
					"lua",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"python",
					"json",
					"markdown",
					"markdown_inline",
				},
				auto_install = true, -- Automatically install missing parsers
				highlight = {
					enable = true, -- Enable syntax highlighting
					additional_vim_regex_highlighting = false, -- Use only Treesitter for highlighting }, indent = { enable = true, -- Enable Treesitter-based indentation }, context_commentstring = { enable = true,      -- Enable context-aware comments (JSX/TSX support)
					enable_autocmd = false, -- Avoid conflicts with other autocommands
				},
				playground = { -- Interactive Treesitter playground for debugging
					enable = true,
					updatetime = 25, -- Debounced time for highlighting nodes
					persist_queries = false, -- Disable query persistence
				},
			})

			-- Enable Treesitter-based folding
			vim.opt.foldmethod = "expr" -- Use expression-based folding
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter folding expression
			vim.opt.foldlevel = 99 -- Open all folds by default
		end,
	},
	{
		"nvim-treesitter/playground", -- Optional, for interactive Treesitter debugging
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable the plugin
				throttle = true, -- Throttle updates for performance
				max_lines = 0, -- No limit for the number of context lines
				patterns = { -- Match patterns for all filetypes
					default = {
						"class",
						"function",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},
				},
			})
		end,
	},
}
