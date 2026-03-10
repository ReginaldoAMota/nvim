return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "Weissle/persistent-breakpoints.nvim",
    },
    keys = {
      { "<leader>bb", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>bB", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, desc = "Breakpoint condicional" },
      { "<leader>bl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Mensagem: ")) end, desc = "Log point" },
      { "<leader>bx", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Limpar breakpoints" },
      { "<leader>bc", function() require("dap").continue() end, desc = "Continuar / iniciar" },
      { "<leader>bi", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>bo", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>bO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>bq", function() require("dap").terminate() end, desc = "Encerrar sessão" },
      { "<leader>br", function() require("dap").restart() end, desc = "Reiniciar sessão" },
      { "<leader>bu", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>be", function() require("dapui").eval() end, desc = "Avaliar expressão", mode = { "n", "v" } },
      { "<leader>bR", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>bL", function() require("dap").run_last() end, desc = "Executar último" },
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continuar" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
    },
    cmd = { "DapContinue", "DapToggleBreakpoint" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Mason DAP: instalar e configurar adaptadores automaticamente
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "delve", "js" },
        handlers = {},
      })

      -- Breakpoints persistentes (salvos em disco)
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })

      -- DAP UI
      dapui.setup()

      -- Abrir/fechar UI automaticamente com sessão de debug
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Ícones de breakpoint
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })

      -- Highlight para linha parada no debugger
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#304030" })

      -- Lua (local-lua-debugger-vscode) — requer Node.js
      dap.adapters["local-lua"] = {
        type = "executable",
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/local-lua-debugger-vscode/extension/debugAdapter.js",
        },
        enrich_config = function(config, on_config)
          if not config["extensionPath"] then
            config = vim.deepcopy(config)
            config.extensionPath = vim.fn.stdpath("data") .. "/mason/packages/local-lua-debugger-vscode/"
          end
          on_config(config)
        end,
      }

      dap.configurations.lua = {
        {
          name = "Lua: Current file",
          type = "local-lua",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = {
            lua = "lua",
            file = "${file}",
          },
        },
      }

      -- Node.js / TypeScript (js-debug-adapter via Mason)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      local js_configs = {
        {
          name = "Node: Executar arquivo atual",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          name = "Node: Attach (porta 9229)",
          type = "pwa-node",
          request = "attach",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          name = "Node: Executar com ts-node",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "ts-node",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          name = "Jest: Arquivo atual",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "node",
          runtimeArgs = { "./node_modules/.bin/jest", "--runInBand", "${file}" },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
      }

      for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[lang] = js_configs
      end
    end,
  },
}
