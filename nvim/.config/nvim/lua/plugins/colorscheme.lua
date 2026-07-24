return {
	-- Importa a suíte Nightfox
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		opts = {
			options = {
				-- Melhora a renderização de cores no terminal/tmux
				terminal_colors = true,
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "bold",
				},
				-- Ajuste específico para a tela do X61s:
				-- Podemos forçar o fundo para preto absoluto (#000000)
				-- ou deixar no padrão do carbonfox (que já é um cinza/preto super escuro #161616)
				palettes = {
					carbonfox = {
						-- Descomente a linha abaixo se quiser o fundo 100% preto
						-- bg1 = "#000000",
					},
				},
			},
		},
	},

	-- Define o carbonfox como o tema principal do LazyVim
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "carbonfox",
		},
	},
}
