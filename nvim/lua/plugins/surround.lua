return {
  {
    "kylechui/nvim-surround",
    version = "*",    -- Use the latest stable version
    event = "VeryLazy", -- Optional: Loads only when needed
    config = function()
      require("nvim-surround").setup({
        -- Add your custom settings here (if needed)
      })
    end,
  },
}
