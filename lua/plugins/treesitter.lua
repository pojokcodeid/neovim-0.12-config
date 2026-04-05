On_event({ "BufRead", "BufNewFile" }, function()
  --: treesitter
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/windwp/nvim-ts-autotag" },
	})

	vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == 'nvim-treesitter' and kind == 'update' then
		if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
		vim.cmd('TSUpdate')
	end
	end })

	require("nvim-treesitter").setup({})
	require("nvim-treesitter").install({
		"lua",
		"vim",
	})

	require("nvim-autopairs").setup({
		check_ts = true,
		ts_config = {
			lua = { "string", "source" },
			javascript = { "string", "template_string" },
			java = false,
		},
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'", "`" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
	})

	require("nvim-ts-autotag").setup({})

	vim.api.nvim_create_user_command("TSInstallInfo", function()
		vim.cmd("Telescope treesitter_info")
	end, {})
end)
--:
