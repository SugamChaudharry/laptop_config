return {
	{
		"akinsho/bufferline.nvim",
		version = "*", -- Use the latest stable version
		dependencies = "nvim-tree/nvim-web-devicons", -- Optional, for file icons
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "none", -- Can be "none", "ordinal", or "buffer_id"
					close_command = "bdelete! %d", -- Command to close buffers
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil, -- Disable middle mouse button
					indicator = {
						style = "icon",
						icon = "▎", -- Or use "none" for no indicator
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 18,
					max_prefix_length = 15, -- Prefix used when a buffer is deduplicated
					tab_size = 18,
					diagnostics = "nvim_lsp", -- Can be "nvim_lsp" or "coc"
					diagnostics_update_in_insert = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					show_buffer_icons = true, -- Enable or disable filetype icons
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					separator_style = "slant", -- Can be "slant", "thick", or "thin"
					enforce_regular_tabs = false,
					always_show_bufferline = true,
				},
			})

			-- Keybindings for Alt+number
			for i = 1, 9 do
				vim.keymap.set("n", "<M-" .. i .. ">", function()
					require("bufferline").go_to_buffer(i, true)
				end, { noremap = true, silent = true, desc = "Go to buffer " .. i })
			end -- For Alt+0 (buffer 10) vim.keymap.set("n", "<M-0>", function() require("bufferline").go_to_buffer(10, true) end, { noremap = true, silent = true, desc = "Go to buffer 10" })

			-- Keybinding for Alt+q to close the current buffer or open Alpha if last buffer
			vim.keymap.set("n", "<M-q>", function()
				local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
				if #listed_buffers == 1 then
					vim.cmd("bdelete!")
					vim.cmd("Alpha")
				else
					vim.cmd("bdelete!")
				end
			end, { noremap = true, silent = true, desc = "Close current buffer or open Alpha if last buffer" })
		end,
	},
}
