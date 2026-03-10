return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: adicionar" })
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: menu" })

      -- Selecionar arquivos (leader+número, sem conflito com tmux navigator)
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: arquivo 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: arquivo 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: arquivo 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: arquivo 4" })

      vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end, { desc = "Harpoon: remover" })

      -- Navegar na lista (sem conflito com gitsigns <leader>hp)
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: próximo" })
      vim.keymap.set("n", "<leader>hN", function() harpoon:list():prev() end, { desc = "Harpoon: anterior" })
    end,
  },
}
