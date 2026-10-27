-- Rodar com (carrega a config real): nvim --headless -c "luafile tests/config_spec.lua"
-- Invariantes da config: caminhos, nomes de servidores, keymaps e opções que já quebraram antes
local home = os.getenv("HOME")
local config_dir = vim.fn.stdpath("config")

local function test(name, fn)
  local ok, err = pcall(fn)
  print((ok and "ok   " or "FAIL ") .. name .. (ok and "" or ("\n     " .. tostring(err))) .. "\n")
  if not ok then
    vim.g.failed = true
  end
end

local function source(file)
  return table.concat(vim.fn.readfile(config_dir .. "/" .. file), "\n")
end

vim.defer_fn(function()
  test("lua_ls aponta para ~/.local/share/LuaAddons (com a barra)", function()
    local path = vim.lsp.config.lua_ls.settings.Lua.workspace.userThirdParty[1]
    assert(path == home .. "/.local/share/LuaAddons", "caminho: " .. tostring(path))
  end)

  test("mason-lspconfig só pede servidores que ele conhece", function()
    local known = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
    for _, name in ipairs(require("mason-lspconfig.settings").current.ensure_installed) do
      assert(known[name], "servidor desconhecido no ensure_installed: " .. name)
    end
  end)

  test("love.lua (config morta no formato LazyVim) foi removido", function()
    assert(vim.uv.fs_stat(config_dir .. "/lua/plugins/love.lua") == nil, "lua/plugins/love.lua ainda existe")
  end)

  test("lazy instala o tokyonight como colorscheme e não usa luarocks", function()
    local opts = require("lazy.core.config").options
    assert(opts.install.colorscheme[1] == "tokyonight", "colorscheme: " .. tostring(opts.install.colorscheme[1]))
    assert(opts.rocks.enabled == false, "rocks ainda habilitado")
  end)

  test("lsp.lua não usa API de diagnóstico obsoleta nem keymaps redundantes", function()
    local src = source("lua/plugins/lsp.lua")
    assert(not src:find("goto_prev", 1, true), "vim.diagnostic.goto_prev ainda é usado")
    assert(not src:find("goto_next", 1, true), "vim.diagnostic.goto_next ainda é usado")
    assert(not src:find("<leader>g<leader>r<leader>", 1, true), "mapeamento estranho de references ainda existe")
  end)

  test("variáveis do netrw não são mais definidas (oil assume o netrw)", function()
    assert(vim.g.netrw_banner == nil, "netrw_banner definido")
    assert(vim.g.netrw_liststyle == nil, "netrw_liststyle definido")
    assert(vim.g.netrw_sizestyle == nil, "netrw_sizestyle definido")
  end)

  test("oil não captura <C-h>/<C-l> (navegação do tmux)", function()
    require("oil")
    local keymaps = require("oil.config").keymaps
    assert(not keymaps["<C-h>"], "<C-h> ainda mapeado no oil")
    assert(not keymaps["<C-l>"], "<C-l> ainda mapeado no oil")
  end)

  test("undodir fica no stdpath('state') do Neovim", function()
    assert(vim.o.undodir == vim.fn.stdpath("state") .. "/undo", "undodir: " .. vim.o.undodir)
  end)

  test("lazydev carregado e como fonte do nvim-cmp", function()
    assert(require("lazy.core.config").plugins["lazydev.nvim"], "lazydev.nvim não está na lista de plugins")
    local names = {}
    for _, s in ipairs(require("cmp").get_config().sources) do
      names[s.name] = true
    end
    assert(names.lazydev, "fonte lazydev ausente no cmp")
  end)

  test("blink.cmp não é instalado (o completion é o nvim-cmp)", function()
    assert(require("lazy.core.config").plugins["blink.cmp"] == nil, "blink.cmp ainda na lista de plugins")
  end)

  test("nvim-lint usa eslint_d em JS/TS", function()
    local by_ft = require("lint").linters_by_ft
    for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
      assert(vim.tbl_contains(by_ft[ft] or {}, "eslint_d"), "eslint_d ausente para " .. ft)
    end
  end)

  test("stylua.toml existe na raiz (formatação consistente)", function()
    assert(vim.uv.fs_stat(config_dir .. "/stylua.toml"), "stylua.toml não existe")
  end)

  vim.cmd((vim.g.failed and "cq" or "qa!"))
end, 300)
