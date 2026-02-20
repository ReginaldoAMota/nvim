return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      -- Provedor de fold: treesitter primeiro, indent como fallback
      require("ufo").setup({
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Abrir todos os folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Fechar todos os folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Abrir folds (exceto tipo)" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Fechar folds" })
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "Hover / peek fold" })
    end,
  },
}
