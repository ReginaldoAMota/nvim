return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "lua", "go", "rust",
          "html", "css",
          "markdown", "markdown_inline",
          "xml", "yaml", "json", "prisma"
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
      })

      local select = function(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end

      -- Select: funções, classes, parâmetros, blocos
      vim.keymap.set({ "x", "o" }, "af", select("@function.outer"))
      vim.keymap.set({ "x", "o" }, "if", select("@function.inner"))
      vim.keymap.set({ "x", "o" }, "ac", select("@class.outer"))
      vim.keymap.set({ "x", "o" }, "ic", select("@class.inner"))
      vim.keymap.set({ "x", "o" }, "aa", select("@parameter.outer"))
      vim.keymap.set({ "x", "o" }, "ia", select("@parameter.inner"))
      vim.keymap.set({ "x", "o" }, "ab", select("@block.outer"))
      vim.keymap.set({ "x", "o" }, "ib", select("@block.inner"))
    end,
  },
}
