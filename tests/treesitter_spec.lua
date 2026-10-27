-- Rodar com (carrega a config real): nvim --headless -c "luafile tests/treesitter_spec.lua"
local dir = vim.fn.tempname()
vim.fn.mkdir(dir, "p")

local function test(name, fn)
  local ok, err = pcall(fn)
  print((ok and "ok   " or "FAIL ") .. name .. (ok and "" or ("\n     " .. tostring(err))) .. "\n")
  if not ok then
    vim.g.failed = true
  end
end

-- Abre o arquivo e faz o parse completo, incluindo as injeções (onde as diretivas rodam)
local function open_and_parse(name, lines)
  local path = dir .. "/" .. name
  vim.fn.writefile(lines, path)
  vim.cmd("edit " .. path)
  vim.wait(100)
  local parser = vim.treesitter.get_parser(0)
  parser:parse(true)
  return parser
end

vim.defer_fn(function()
  test("markdown com bloco de código injetado (set-lang-from-info-string!)", function()
    local parser = open_and_parse("a.md", { "# Título", "", "```LUA", "local x = 1", "```" })
    assert(parser:children().lua, "injeção de lua não encontrada")
    assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "highlight não está ativo")
  end)

  test("html com script type (set-lang-from-mimetype!)", function()
    local parser = open_and_parse("a.html", { '<script type="text/javascript">', "let x = 1", "</script>" })
    assert(parser:children().javascript, "injeção de javascript não encontrada")
    assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "highlight não está ativo")
  end)

  test("indentexpr vem do treesitter", function()
    open_and_parse("a.lua", { "local x = 1" })
    assert(vim.bo.indentexpr:find("require'nvim%-treesitter'%.indentexpr") ~= nil, "indentexpr: " .. vim.bo.indentexpr)
  end)

  vim.cmd((vim.g.failed and "cq" or "qa!"))
end, 300)
