return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "luacheck" },
        c = { "clangtidy" },
        cpp = { "clangtidy" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      -- Configurar luacheck para reconhecer globals do Neovim
      lint.linters.luacheck.args = {
        "--globals",
        "vim",
        "--no-unused-args",
        "--formatter",
        "plain",
        "--codes",
        "--ranges",
        "-",
      }

      -- Rodar o linter automaticamente
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
