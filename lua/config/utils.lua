local M = {}

function M.run_file_on_terminal()
  vim.cmd("write") -- Salva o arquivo antes de executar

  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p")

  local runners = {
    lua = "lua",
    javascript = "bun",
    typescript = "bun",
    go = "go run",
    rust = "cargo run",
  }

  local runner = runners[filetype]
  vim.fn.jobstart({ runner, filename }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        print(table.concat(data, "\n"))
      end
    end,
  })
end

return M
