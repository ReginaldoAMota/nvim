return { {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      -- Configurações visuais
      columns = {
        "icon",
      },

      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      -- Configurações da janela (não flutuante)
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        concealcursor = "nvic",
        conceallevel = 3,
      },
      -- Remove o lixo (trash) por segurança ou habilite se preferir
      delete_to_trash = false,
      -- Pular confirmação para edições simples (opcional)
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true, -- Mostra arquivos ponto (.)
      },
    })

    -- Atalho clássico: o hífen abre o diretório do arquivo atual
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir diretório pai" })
    vim.keymap.set("n", "<leader>pv", function() require("oil").toggle_float() end)
  end
} }
