Later(function()
	vim.pack.add({
		{ src = "https://github.com/pojokcodeid/dressing.nvim" },
	})

	vim.ui.select = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end

	require("dressing").setup({
		input = {
			enabled = false,
			title_pos = "center",
			relative = "editor",
			default_prompt = "➤ ",
			win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
			prefer_width = 30,
			max_width = { 140, 0.9 },
			min_width = { 50, 0.2 },
		},
		select = {
			backend = { "telescope", "builtin" },
			builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
		},
	})
end)
