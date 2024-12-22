return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<leader>n]],
      direction = "float",
      shade_terminals = true,
      insert_mappings = false,
      start_in_insert = true,
      opts = {
        open_mapping = [[<leader>n]],
        direction = "horizontal",
        shade_filetypes = {},
        insert_mappings = true,
        hide_numbers = true,
        terminal_mappings = true,
        start_in_insert = true,
        close_on_exit = true,
        shell = vim.o.shell,
      },
    })
  end,
}
