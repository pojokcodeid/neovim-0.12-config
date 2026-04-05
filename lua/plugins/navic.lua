On_event({ "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		"https://github.com/LunarVim/breadcrumbs.nvim",
		"https://github.com/SmiteshP/nvim-navic",
	})

	local icons = require("configs.icons").kind
	for key, value in pairs(icons) do
		icons[key] = value .. " "
	end

	require("breadcrumbs").setup()
	require("nvim-navic").setup({
		icons = icons,
		lsp = {
			auto_attach = true,
			preference = nil,
		},
		highlight = false,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
		lazy_update_context = false,
		click = false,
		format_text = function(text)
			return text
		end,
	})
end)
