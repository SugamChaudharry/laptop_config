return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,              -- Default terminal size
      direction = "float",    -- Default terminal direction
      shade_terminals = true, -- Apply shading to terminal
      start_in_insert = true, -- Start terminal in insert mode
      close_on_exit = true,   -- Close terminal when process exits
      shell = vim.o.shell,    -- Use default shell

      float_opts = {          -- Float-specific options
        border = "single",
        width = function()
          local total_width = vim.o.columns
          return math.floor(total_width - (total_width / 6)) -- Use 5/6 of screen width
        end,
        height = function()
          local total_height = vim.o.lines
          return math.floor(total_height - (total_height / 5)) -- Use 4/5 of screen height
        end,
      },
    })
  end,
}
