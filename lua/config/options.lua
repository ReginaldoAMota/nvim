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
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Mostra caracteres invisíveis: pontos na indentação (tab/espaços) e espaços em branco no fim da linha
opt.list = true
opt.listchars = {
  tab = "› ",
  trail = "",
  nbsp = "␣",
  leadmultispace = " ",
}

opt.termguicolors = true
-- Mesma fonte do kitty (kitty.conf: font_family/font_size). Só tem efeito em
-- clientes GUI (Neovide etc.); no terminal quem desenha os glifos é o kitty.
opt.guifont = "Terminess Nerd Font Mono:h12"
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50
opt.colorcolumn = "80"
opt.splitright = true
opt.splitbelow = true

-- Folding via treesitter (gerenciado pelo nvim-ufo)
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
