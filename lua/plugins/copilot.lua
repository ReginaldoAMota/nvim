return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-Right>",
            accept_line = "<M-Down>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          yaml = true,
          help = false,
          gitcommit = true,
        },
      })
    end,
  },
}
