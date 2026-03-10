return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Text objects melhorados, sem 'f' para evitar conflito com treesitter textobjects
      require("mini.ai").setup({
        n_lines = 500,
        custom_textobjects = {
          f = false, -- Delegado ao treesitter textobjects (@function)
        },
      })

      -- Operações de surround (estilo vim-surround): ys, ds, cs
      require("mini.surround").setup({
        mappings = {
          add = "ys", -- ysiw" para adicionar surrounding
          delete = "ds", -- ds" para deletar surrounding
          find = "", -- Desabilitado para evitar conflito com flash
          find_left = "", -- Desabilitado
          highlight = "", -- Desabilitado
          replace = "cs", -- cs"' para trocar surrounding
          update_n_lines = "", -- Desabilitado
        },
      })

      -- Remover mapeamento visual do ys e usar S no lugar (estilo vim-surround)
      vim.keymap.del("x", "ys")
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

      -- yss para adicionar surrounding na linha inteira
      vim.keymap.set("n", "yss", "ys_", { remap = true })

      -- Comentários: gcc (linha), gc (visual)
      require("mini.comment").setup()

      -- Highlight da palavra sob o cursor
      require("mini.cursorword").setup()

      -- Linha vertical mostrando o escopo atual (função, bloco, tag, etc.)
      require("mini.indentscope").setup({
        symbol = "│",
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })

      -- Notificações substituindo o vim.notify padrão
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
    end,
  },
}
