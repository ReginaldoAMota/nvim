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

function M.build_asm_file()
  vim.cmd("write") -- Salva o arquivo antes de buildar

  local filename = vim.fn.expand("%:p")
  local basename = vim.fn.expand("%:p:r")

  local cmd = string.format(
    "nasm -f elf64 %s -o %s.o && ld %s.o -o %s",
    filename, basename, basename, basename
  )

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        print(table.concat(data, "\n"))
      end
    end,
    on_stderr = function(_, data)
      if data then
        print(table.concat(data, "\n"))
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        print("Build ok -> " .. basename)
      else
        print("Build falhou (código " .. code .. ")")
      end
    end,
  })
end

return M
