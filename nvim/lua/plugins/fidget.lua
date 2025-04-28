return {
  {
    "j-hui/fidget.nvim",
    config = function()
      require('fidget').setup({
        progress = {
          display = {
            render_limit = 2,
            done_ttl = 1.5,
          }
        }
      })
    end,
    event = "LspAttach", -- Lazy-load when LSP attaches to a buffer
  },
}
