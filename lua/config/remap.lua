local map = vim.keymap.set
local utils = require("config.utils")

-- Explorador de arquivos
-- map("n", "<leader>pv", vim.cmd.Ex)

-- Mover linhas selecionadas
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Manter cursor no centro ao navegar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Colar sem perder o registro
map("x", "<leader>p", [["_dP]])

-- Copiar para clipboard do sistema
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Deletar sem sujar o registro
map({ "n", "v" }, "<leader>d", [["_d]])

-- Fechar buffer de diagnóstico com Q
map("n", "Q", "<nop>")

-- Trocar de projeto
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Navegar entre quickfix (]q/[q para não conflitar com tmux navigator)
map("n", "]q", "<cmd>cnext<CR>zz")
map("n", "[q", "<cmd>cprev<CR>zz")
map("n", "]l", "<cmd>lnext<CR>zz")
map("n", "[l", "<cmd>lprev<CR>zz")

-- Substituir palavra sob o cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Tornar arquivo executável
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


map("n", "<leader>rt", utils.run_file_on_terminal, { desc = "Run current file" })
