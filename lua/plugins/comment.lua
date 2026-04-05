On_event({ "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
		"https://github.com/numToStr/Comment.nvim",
	})

	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})

	vim.keymap.set(
		"n",
		"<leader>/",
		"<Plug>(comment_toggle_linewise_current)",
		{ noremap = true, silent = true, desc = "Coment Line" }
	)
	vim.keymap.set(
		"v",
		"<leader>/",
		"<Plug>(comment_toggle_linewise_visual)",
		{ noremap = true, silent = true, desc = "Coment Line" }
	)
end)
