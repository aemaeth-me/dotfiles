return {
	{
		"carlos-algms/agentic.nvim",
		dependencies = {
			{ "hakonharnes/img-clip.nvim", opts = {} },
		},
		opts = {
			provider = "opencode-acp",
		},
		keys = {
			{
				"<leader>aa",
				function() require("agentic").toggle() end,
				mode = { "n", "v", "i" },
				desc = "Toggle Agentic Chat",
			},
			{
				"<leader>ac",
				function() require("agentic").add_selection_or_file_to_context() end,
				mode = { "n", "v" },
				desc = "Add to Agentic Context",
			},
			{
				"<leader>an",
				function() require("agentic").new_session() end,
				mode = { "n", "v", "i" },
				desc = "Agentic New Session",
			},
			{
				"<leader>ar",
				function() require("agentic").restore_session() end,
				desc = "Agentic Restore Session",
				mode = { "n", "v", "i" },
			},
			{
				"<leader>ad",
				function() require("agentic").add_current_line_diagnostics() end,
				desc = "Add line diagnostics to Agentic",
				mode = { "n" },
			},
			{
				"<leader>aD",
				function() require("agentic").add_buffer_diagnostics() end,
				desc = "Add buffer diagnostics to Agentic",
				mode = { "n" },
			},
		},
	},
}
