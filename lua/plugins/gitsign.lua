On_event({ "VimEnter" }, function()
	vim.pack.add({
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	})

	require("gitsigns").setup({
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		status_formatter = nil, -- Use default
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
	-- stylua: ignore
	vim.keymap.set("n", "<leader>g", "", { expr = true, desc = "Git" })
	vim.keymap.set("n", "<leader>gj", function()
		require("gitsigns").next_hunk()
	end, { expr = true, desc = "Next Hunk" })
	vim.keymap.set("n", "<leader>gk", function()
		require("gitsigns").prev_hunk()
	end, { expr = true, desc = "Prev Hunk" })
	vim.keymap.set("n", "<leader>gl", function()
		require("gitsigns").blame_line()
	end, { expr = true, desc = "Blame" })
	vim.keymap.set("n", "<leader>gp", function()
		require("gitsigns").preview_hunk()
	end, { expr = true, desc = "Preview Hunk" })
	vim.keymap.set("n", "<leader>gr", function()
		require("gitsigns").reset_hunk()
	end, { expr = true, desc = "Reset Hunk" })
	vim.keymap.set("n", "<leader>gR", function()
		require("gitsigns").reset_buffer()
	end, { expr = true, desc = "Reset Buffer" })
	vim.keymap.set("n", "<leader>gs", function()
		require("gitsigns").stage_hunk()
	end, { expr = true, desc = "Stage Hunge" })
	vim.keymap.set("n", "<leader>gu", function()
		require("gitsigns").undo_stage_hunk()
	end, { expr = true, desc = "Undo Stage Hunge" })
	vim.keymap.set(
		"n",
		"<leader>go",
		"<cmd>Telescope git_status<cr>",
		{ noremap = true, silent = true, desc = "Opened Changed File" }
	)
	vim.keymap.set(
		"n",
		"<leader>gb",
		"<cmd>Telescope git_branches<cr>",
		{ noremap = true, silent = true, desc = "Checkout Branch" }
	)
	vim.keymap.set(
		"n",
		"<leader>gc",
		"<cmd>Telescope git_commits<cr>",
		{ noremap = true, silent = true, desc = "Checkout Commit" }
	)
	vim.keymap.set(
		"n",
		"<leader>gd",
		"<cmd>Gitsigns diffthis HEAD<cr>",
		{ noremap = true, silent = true, desc = "Diff" }
	)
end)
