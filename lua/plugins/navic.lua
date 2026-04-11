On_event({ "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		"https://github.com/LunarVim/breadcrumbs.nvim",
		"https://github.com/SmiteshP/nvim-navic",
	})

	require("breadcrumbs").setup()
	require("nvim-navic").setup({
		lsp = {
			auto_attach = true,
			preference = nil,
		},
	})
end)
