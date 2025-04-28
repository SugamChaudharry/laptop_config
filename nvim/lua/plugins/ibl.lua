return {
  {
    "lukas-reineke/indent-blankline.nvim",
    name = "ibl", -- Optional alias for clarity
    config = function()
      require('ibl').setup({
        indent = { char = '' },
        scope = {
          show_start = false,
          show_end = false,
          exclude = {
            language = { 'NvimTree', 'toggleterm', 'Function', 'help' }
          }
        },
      })
    end,
    event = "BufReadPre", -- Load on buffer read
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- Use the latest version
    config = function()
      require('mini.indentscope').setup({
        symbol = '',
      })
    end,
    event = "BufReadPre", -- Load on buffer read
  },
}
