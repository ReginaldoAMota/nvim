return { {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- Ou "github/copilot.vim"
    { "nvim-lua/plenary.nvim" },
  },
  build = "make", -- Importante para performance
  opts = {
    debug = false,
  },
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>",  desc = "CopilotChat - Toggle" },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
  },
} }
