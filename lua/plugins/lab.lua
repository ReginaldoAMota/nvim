return {
	{
		"0x100101/lab.nvim",
		-- Executa a instalação de dependências Javascript do Faker após o download
		build = "cd js && npm ci",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			quick_data = {
				enabled = true, -- Garante que o Quick Data está ativado
			},
		},
	},
}
