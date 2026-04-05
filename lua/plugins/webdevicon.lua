Later(function()
	vim.pack.add({
		{ src = "https://github.com/pojokcodeid/nvim-material-icon" },
		{ src = "https://github.com/kyazdani42/nvim-web-devicons" },
	})

	local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
	if not material_icon_ok then
		return
	end
	material_icon.setup({
		override = {},
	})

	require("nvim-web-devicons").setup({
		override = material_icon.get_icons(),
		override_by_filename = {},
	})
end)
