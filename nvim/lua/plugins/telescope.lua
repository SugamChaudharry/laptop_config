return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim", -- For UI dropdown
			"AckslD/nvim-neoclip.lua", -- Clipboard manager
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local themes = require("telescope.themes")
			-- Telescope setup
			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"dist",
						"build",
						"static",
						"packer_compiled.lua",
						"nvim-tree.lua",
						"target",
						".git/",
						"CMakeFiles",
					},
					mappings = {
						n = {
							["<C-v>"] = actions.select_vertical,
							["<C-h>"] = actions.select_horizontal,
						},
						i = {
							["<C-v>"] = actions.select_vertical,
							["<C-h>"] = actions.select_horizontal,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- Include hidden files
					},
				},
				extensions = {
					["ui-select"] = {
						themes.get_dropdown({}), -- Use dropdown theme
					},
				},
			})

			-- Load Telescope extensions
			telescope.load_extension("ui-select")
			telescope.load_extension("neoclip")

			-- Keybindings
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Recent Files" })
			vim.keymap.set(
				"n",
				"<leader>fp",
				":Telescope find_files cwd=<project_directory><CR>",
				{ desc = "Project Files" }
			)

			-- Additional Telescope keybindings
			vim.keymap.set("n", "<leader>dn", builtin.diagnostics, { desc = "LSP Diagnostics" })
			vim.keymap.set("n", "<leader>sg", builtin.spell_suggest, { desc = "Spell Suggest" })
		end,
	},
}
