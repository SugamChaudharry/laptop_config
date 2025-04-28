-- return {
-- 	"declancm/cinnamon.nvim",
-- 	config = function()
-- 		require("cinnamon").setup({
-- 			disabled = false, -- Disable the plugin
-- 			keymaps = {
-- 				basic = true, -- Enable the basic keymaps
-- 				extra = true, -- Enable the extra keymaps
-- 			},
--
-- 			options = {
-- 				mode = "window",
-- 				-- mode = "cursor",
-- 				callback = function() -- Post-movement callback
-- 				end,
-- 				delay = 3, -- Delay between each movement step (in ms)
-- 				max_delta = {
-- 					-- line = 150, -- Maximum delta for line movements
-- 					-- column = 200, -- Maximum delta for column movements
-- 				},
-- 			},
-- 		})
-- 	end,
-- }
return {
	"declancm/cinnamon.nvim",
	config = function()
		require("cinnamon").setup({
			disabled = false, -- Plugin is enabled
			keymaps = {
				basic = false, -- Disable basic keymaps (includes j, k, etc.)
				extra = false, -- Disable extra keymaps (if any)
			},
			options = {
				mode = "window", -- Keep scrolling mode as "window"
				callback = function() -- Post-movement callback (optional)
				end,
				delay = 3, -- Delay between each movement step (in ms)
				max_delta = {
					-- Customize max delta if needed
				},
			},
		})
	end,
}
