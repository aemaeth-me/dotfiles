return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"haskell-language-server",
				"fourmolu",
				"hlint",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				hls = {
					filetypes = { "haskell", "cabal", "lhaskell" },
				},
			},
		},
	},
}
