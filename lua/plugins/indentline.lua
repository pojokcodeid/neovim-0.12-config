On_event({ "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		{ src = "https://github.com/shellRaining/hlchunk.nvim" },
	})
	require("hlchunk").setup({
		chunk = {
			enable = true,
			-- ...
		},
		indent = {
			enable = true,
			-- ...
		},
		exclude_filetypes = {
			aerial = true,
			dashboard = true,
			alpha = true,
			-- some other filetypes
		},
	})
end)
