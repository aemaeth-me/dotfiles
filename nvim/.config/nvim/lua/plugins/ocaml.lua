return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			local opam_bin = vim.fn.expand("~/.opam/default/bin")
			if vim.fn.isdirectory(opam_bin) == 1 then
				vim.env.PATH = opam_bin .. ":" .. (vim.env.PATH or "")
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "ocaml", "ocamlinterface" },
				callback = function(args)
					vim.keymap.set("n", ";ci", "<cmd>LspOcamllspSwitchImplIntf<CR>", {
						buffer = args.buf,
						desc = "Switch .ml/.mli",
					})
				end,
			})
		end,
		opts = {
			servers = {
				ocamllsp = {
					mason = false,
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				ocaml = { "ocamlformat" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ ";c", group = "ocaml" },
			},
		},
	},
}
