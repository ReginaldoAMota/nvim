local parsers = {
  "javascript",
  "typescript",
  "tsx",
  "c",
  "cpp",
  "vimdoc",
  "vim",
  "query",
  "lua",
  "go",
  "rust",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  "xml",
  "yaml",
  "json",
  "prisma",
  "kotlin",
  "dart",
  "asm",
  "bash",
  "make",
}

return {
  {
    -- Branch "main": o "master" está congelado e não suporta o Neovim 0.12
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      -- O "main" não liga highlight/indent sozinho: ativa por filetype
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then
            return
          end
          -- Substitui o auto_install: instala o parser que faltar (async)
          if not vim.treesitter.language.add(lang) then
            if vim.tbl_contains(require("nvim-treesitter").get_available(), lang) then
              require("nvim-treesitter").install(lang)
            end
            return
          end
          vim.treesitter.start(args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Seleção incremental: nativa no Neovim 0.12 ("an" expande, "in" reduz no modo visual)
      vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Selecionar nó treesitter" })
      vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Expandir seleção treesitter" })
      vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Reduzir seleção treesitter" })
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
