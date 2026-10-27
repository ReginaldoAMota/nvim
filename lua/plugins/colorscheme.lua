return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#545c7e" })
    end,
  },
}
