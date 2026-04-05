On_event({ "BufRead", "BufNewFile" }, function()
	vim.pack.add({
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/pojokcodeid/auto-conform.nvim" },
	})
	local format_on_save = true
	local format_timeout_ms = 5000
	require("auto-conform").setup({
		formatters = {},
		formatters_by_ft = {},
		ensure_installed = {},
		lang_maps = {},
		name_maps = {},
		add_new = {},
		ignore = {},
		format_on_save = format_on_save,
		format_timeout_ms = format_timeout_ms,
	})
	-- other conform config
	local conform = require("conform")
	if format_on_save then
		conform.setup({
			format_on_save = function()
				return {
					lsp_fallback = true,
					timeout_ms = format_timeout_ms,
				}
			end,
		})
	end
	vim.keymap.set({ "n", "v" }, "<leader>lF", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = format_timeout_ms,
		})
	end, { desc = "Format file or range (in visual mode)" })
end)
