--: nvim-notify
vim.pack.add({
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

require("noice").setup({
	messages = {
		enabled = false,
	},
	notify = {
		enabled = false,
	},
	lsp = {
		progress = {
			enabled = false,
		},
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
	presets = {
		-- Preset ini menyesuaikan bentuk cursor pada mode commond
		command_bar_cursor = {
			enabled = true,
			cursor_shape = "ver30", -- "ver" menandakan bar vertikal, 30 adalah tinggi dalam persen
		},
	},
})

local notify = require("notify")
notify.setup({
	timeout = 3000,
	max_height = function()
		return math.floor(vim.o.lines * 0.75)
	end,
	max_width = function()
		return math.floor(vim.o.columns * 0.4)
	end,
	render = "wrapped-compact",
})
vim.notify = notify.notify
--:
