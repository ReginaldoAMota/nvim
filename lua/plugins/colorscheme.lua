return {
  {
    "xiantang/darcula-dark.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.cmd("colorscheme darcula-dark")
    end,
  },
}
