return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        delay = 300,
      })

      -- Registrar grupos de prefixos
      wk.add({
        { "<leader>f", group = "buscar" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunks/harpoon" },
        { "<leader>c", group = "código" },
        { "<leader>w", group = "workspace" },
        { "<leader>d", group = "diagnóstico" },
      })
    end,
  },
}
