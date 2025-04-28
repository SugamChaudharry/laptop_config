return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    branch = "disable-x-requested-with-header",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true, -- Load only when required
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true, -- Load only when required
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
}
