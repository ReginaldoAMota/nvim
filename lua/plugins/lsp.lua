return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnósticos visuais
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Keymaps via LspAttach (abordagem 0.11+)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          -- [d / ]d / grr / grn / gra / gri / grt já vêm mapeados por padrão no Neovim 0.11+

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.name == "clangd" then
            -- Inlay hints (tipos/nomes de parâmetro) ligados por padrão
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            end
            vim.keymap.set("n", "<leader>ih", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
            end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

            -- Alternar entre .c/.cpp e o .h correspondente
            vim.keymap.set("n", "<leader>ch", function()
              local params = vim.lsp.util.make_text_document_params(ev.buf)
              vim.lsp.buf_request(ev.buf, "textDocument/switchSourceHeader", params, function(err, result)
                if err then
                  vim.notify("clangd: " .. err.message, vim.log.levels.ERROR)
                  return
                end
                if not result or result == "" then
                  vim.notify("Nenhum header/source correspondente encontrado", vim.log.levels.INFO)
                  return
                end
                vim.cmd.edit(vim.uri_to_fname(result))
              end)
            end, vim.tbl_extend("force", opts, { desc = "Switch Source/Header" }))
          end
        end,
      })

      -- Capabilities globais para todos os servidores
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Config específica do lua_ls
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "love" } },
            workspace = {
              -- Path to your Addons directory
              userThirdParty = { os.getenv("HOME") .. "/.local/share/LuaAddons" },
              checkThirdParty = "Apply",
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Config específica do clangd (C/C++)
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--all-scopes-completion",
          "--pch-storage=memory",
        },
      })

      -- Config específica do asm_lsp
      vim.lsp.config("asm_lsp", {
        cmd = { "asm-lsp" },
        filetypes = { "asm", "s", "S" },
      })

      -- Mason
      require("mason").setup({ ui = { border = "rounded" } })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "clangd",
          "html",
          "cssls",
          "marksman",
          "lemminx",
          "yamlls",
          "jsonls",
          "kotlin_language_server",
          "asm_lsp",
        },
        automatic_enable = true,
      })
    end,
  },
}
