return { {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Adaptadores
    "rouge8/neotest-rust",
    "marilari88/neotest-vitest", -- Para Vitest/TypeScript
    "haydenmeade/neotest-jest",  -- Use este se o seu projeto usar Jest
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust")({
          args = { "--no-capture" },
        }),
        require("neotest-jest")({
          -- O adaptador tenta encontrar o vitest.config.ts automaticamente
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
        }),
      },
      -- Interface e Comportamento
      status = { virtual_text = true },
      output = { open_on_run = true },
      icons = {
        passed = "✔",
        running = "󰑮",
        failed = "✖",
        unknown = "❓"
      },
    })

    -- Atalhos (mantendo o padrão)
    local neotest = require("neotest")
    vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Run Nearest Test" })
    vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
    vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle Summary" })
    vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Show Output" })
  end,
} }
