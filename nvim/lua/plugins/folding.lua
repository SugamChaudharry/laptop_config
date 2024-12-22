return {
	-- ufo folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.scfa" },
							{ text = { "%s" }, click = "v:lua.scsa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.scla" },
						},
					})
				end,
			},
		},
		event = "bufreadpost",
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},

		-- init = function()
		-- 	vim.keymap.set("n", "zr", function()
		-- 		require("ufo").openallfolds()
		-- 	end)
		-- 	vim.keymap.set("n", "zm", function()
		-- 		require("ufo").closeallfolds()
		-- 	end)
		-- end,
	},
	-- -- folding preview, by default h and l keys are used.
	-- -- on first press of h key, when cursor is on a closed fold, the preview will be shown.
	-- -- on second press the preview will be closed and fold will be opened.
	-- -- when preview is opened, the l key will close it and open fold. in all other cases these keys will work as usual.
	-- {
	-- 	"anuvyklack/fold-preview.nvim",
	-- 	event = "bufreadpost",
	-- 	dependencies = "anuvyklack/keymap-amend.nvim",
	-- 	config = true,
	-- },
}
