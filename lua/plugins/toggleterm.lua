On_event({ "VimEnter" }, function()
	vim.pack.add({
		{ src = "https://github.com/akinsho/toggleterm.nvim" },
	})
	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})
	function _G.set_terminal_keymaps()
		local optsn = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], optsn)
		vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], optsn)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], optsn)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], optsn)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], optsn)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], optsn)
	end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  
    vim.keymap.set("n", "<leader>gg", "<cmd>lua LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Lazygit" })
    vim.keymap.set("n", "<leader>t", "", { expr = true, desc = "Terminal" })
    vim.keymap.set("n", "<leader>tx", "<cmd>ToggleTermToggleAll!<cr>", { noremap = true, silent = true, desc = "Close Tab"})
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { noremap = true, silent = true, desc = "Float"})
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { noremap = true, silent = true, desc = "Horizontal"})
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { noremap = true, silent = true, desc = "Vertical"})
    vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm direction=tab<cr>", { noremap = true, silent = true, desc = "New Tab"})
end)

