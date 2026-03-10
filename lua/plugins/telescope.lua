return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
            },
          },
        },
      })

      pcall(telescope.load_extension, "fzf")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar no conteúdo" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Ajuda" })
      vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Buscar palavra atual" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Arquivos recentes" })
      vim.keymap.set("n", "<leader>fd", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Diagnósticos (arquivo atual)" })
    end,
  },
}
