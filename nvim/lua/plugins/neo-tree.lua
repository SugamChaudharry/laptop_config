return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Show hidden files
					hide_gitignored = false, -- Optionally show gitignored files
				},
			},
		})

		-- Key mappings
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle float<CR>", { silent = true, desc = "Float File Explorer" })
		vim.keymap.set("n", "<C-n>", ":Neotree toggle left<CR>", { silent = true, desc = "Left File Explorer" })
	end,
}
