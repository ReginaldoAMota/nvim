return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Texto objects melhorados (ex: vai = inner arg, vaf = função, etc.)
      require("mini.ai").setup({ n_lines = 500 })

      -- Operações de surround: ys, ds, cs
      require("mini.surround").setup()

      -- Comentários: gcc (linha), gc (visual)
      require("mini.comment").setup()
    end,
  },
}
