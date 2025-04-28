return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = 'dracula', -- Use 'dracula', fallback to 'auto' if unspecified
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'packer', 'NvimTree' }, -- Ensure correct capitalization of 'NvimTree'
      }
    })

    -- Optional: Set `laststatus = 1` to hide the status line when there's only one window
    vim.opt.laststatus = 1
  end
}
