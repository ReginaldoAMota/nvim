local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50
opt.colorcolumn = "80"
opt.splitright = true
opt.splitbelow = true

-- Netrw (explorador de arquivos nativo)
vim.g.netrw_banner = 0        -- remove o banner de comandos do topo
vim.g.netrw_liststyle = 3     -- estilo árvore
vim.g.netrw_sizestyle = "H"   -- tamanhos legíveis (KB, MB)

-- Folding via treesitter (gerenciado pelo nvim-ufo)
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
