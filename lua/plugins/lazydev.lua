return {
  {
    -- Tipos e autocompletar da API do Neovim (vim.*) e dos plugins no lua_ls,
    -- só em arquivos Lua da config; substitui o .luarc.json que apontava para o love2d
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
