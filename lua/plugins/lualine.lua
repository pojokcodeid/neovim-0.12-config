On_event({ "InsertEnter", "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		{ src = "https://github.com/nvim-lualine/lualine.nvim" },
		{ src = "https://github.com/pojokcodeid/auto-lualine.nvim" },
	})

	require("auto-lualine").setup({
		setColor = "auto",
		setOption = "roundedall",
		setMode = 5,
	})
end)
