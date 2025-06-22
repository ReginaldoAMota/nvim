-- Define a tecla <leader> como espaço (usada como prefixo para atalhos personalizados)
vim.g.mapleader = " "

-- Abre o navegador de arquivos (netrw)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Mover linha(s) selecionadas no modo visual para baixo ou cima
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- move linha(s) para baixo
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- move linha(s) para cima

-- Junta a linha de baixo com a atual sem mover o cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Ao rolar com Ctrl+d ou Ctrl+u, mantém o cursor centralizado
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Ao buscar com n ou N, mantém o cursor centralizado e a seleção visível
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Reindenta ao redor do cursor mantendo a posição
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Reinicia o servidor LSP (útil para corrigir erros de linguagem)
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Navegação entre painéis usando Alt + (h, j, k, l)
vim.keymap.set("n", "<A-h>", "<C-w>h")  -- esquerda
vim.keymap.set("n", "<A-j>", "<C-w>j")  -- baixo
vim.keymap.set("n", "<A-k>", "<C-w>k")  -- cima
vim.keymap.set("n", "<A-l>", "<C-w>l")  -- direita

-- Substitui texto selecionado sem copiar o texto substituído
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copia para o sistema (clipboard) com <leader>y ou <leader>Y
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deleta sem salvar no registro padrão
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Usa Ctrl+c no modo insert como se fosse <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Desativa o comando Q (modo Ex, raramente usado)
vim.keymap.set("n", "Q", "<nop>")

-- Abre nova sessão do tmux-sessionizer (útil para gerenciar sessões tmux)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Formata o buffer atual usando o plugin conform
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ bufnr = 0 })
end)

-- Navega entre erros do quickfix (Ctrl+k / Ctrl+j) ou da lista local (leader+k / leader+j)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitui a palavra sob o cursor em todo o arquivo (com confirmação de palavra)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Torna o arquivo atual executável
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

