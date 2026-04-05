On_event({ "InsertEnter", "BufRead", "BufNewFile" }, function()
    vim.pack.add({
		{ src = "https://github.com/mfussenegger/nvim-lint" },
		{ src = "https://github.com/pojokcodeid/auto-lint.nvim" },
    })
    require("auto-lint").setup({
        map_lang = {},
		map_name =  {},
		add_new = {},
		ignore =  {},
		ensure_installed = {}
    })
end)