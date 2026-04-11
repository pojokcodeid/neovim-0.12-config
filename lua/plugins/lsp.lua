-- load jika dibuka
-- Later(function()
On_event({ "VimEnter" }, function()
	vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
		{ src = "https://github.com/saghen/blink.cmp" },
		{ src = "https://github.com/rafamadriz/friendly-snippets" },
		{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("^2") },
		{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
		{ src = "https://github.com/mikavilpas/blink-ripgrep.nvim" },
		{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	})

	local icons = require("configs.icons").ui

	-- :mason config
	require("mason").setup({
		ensure_installed = { "stylua" },
		ui = {
			border = "rounded", -- Options: "none", "single", "double", "rounded", "solid", "shadow"
		},
	})

	-- :mason lsp config
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls" },
	})
	local option = {}
	local installed_servers = require("mason-lspconfig").get_installed_servers()
	local map = function(keys, func, desc, mode, bufnr)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
	end

	vim.diagnostic.config({
		underline = false,
		virtual_text = false,
		update_in_insert = false,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
		},
		virtual_lines = { current_line = true },
	})

	-- :register lsp
	for _, server_name in ipairs(installed_servers) do
		local capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		}
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
		option = {
			on_attach = function(client, bufnr)
				map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration", "n", bufnr)
				map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition", "n", bufnr)
				map("<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition", "n", bufnr)
				map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover", "n", bufnr)
				map("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation", "n", bufnr)
				map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References", "n", bufnr)
				map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics", "n", bufnr)
				map("<leader>l", "", "LSP", "n", bufnr)
				map("<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format", "n", bufnr)
				map("<leader>li", "<cmd>LspInfo<cr>", "Information", "n", bufnr)
				map("<leader>lI", "<cmd>Mason<cr>", "Mason Information", "n", bufnr)
				map("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", "n", bufnr)
				map("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next Diagnostic", "n", bufnr)
				map("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic", "n", bufnr)
				map("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", "n", bufnr)
				map("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help", "n", bufnr)
				map("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix", "n", bufnr)
			end,
			capabilities = capabilities,
		}
		server_name = vim.split(server_name, "@")[1]
		local require_ok, conf_opts = pcall(require, "lsp." .. server_name)
		if require_ok then
			option = vim.tbl_deep_extend("force", conf_opts, option)
		end
		vim.lsp.config(server_name, option)
		vim.lsp.enable(server_name)
	end

	-- :config highlight color
	vim.opt.termguicolors = true
	require("colorful-menu").setup({})

	-- :config blink-cmp
	require("blink.cmp").setup({
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						local has_words_before = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							if col == 0 then
								return false
							end
							local line = vim.api.nvim_get_current_line()
							return line:sub(col, col):match("%s") == nil
						end

						return cmp.select_next({ auto_insert = has_words_before() })
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.snippet_backward()
					else
						return cmp.select_prev()
					end
				end,
				"fallback",
			},
			["<CR>"] = { "accept", "fallback" },
			["<C-u>"] = {
				"scroll_documentation_up",
				"fallback",
			},
			["<C-d>"] = {
				"scroll_documentation_down",
				"fallback",
			},
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-N>"] = { "select_next", "show" },
			["<C-P>"] = { "select_prev", "show" },
			["<C-J>"] = { "select_next", "fallback" },
			["<C-K>"] = { "select_prev", "fallback" },
			["<C-U>"] = { "scroll_documentation_up", "fallback" },
			["<C-D>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			menu = {
				border = "rounded",
				draw = {
					padding = 2,
					gap = 1,
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
					-- config colorful-menu
					components = {
						label = {
							text = require("colorful-menu").blink_components_text,
							highlight = require("colorful-menu").blink_components_highlight,
						},
						-- customize the drawing of kind icons
						kind_icon = {
							text = function(ctx)
								-- default kind icon
								local icon = ctx.kind_icon
								-- if LSP source, check for color derived from documentation
								if ctx.item.source_name == "LSP" then
									local color_item = require("nvim-highlight-colors").format(
										ctx.item.documentation,
										{ kind = ctx.kind }
									)
									if color_item and color_item.abbr ~= "" then
										icon = color_item.abbr
									end
								end
								return icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								-- default highlight group
								local highlight = "BlinkCmpKind" .. ctx.kind
								-- if LSP source, check for color derived from documentation
								if ctx.item.source_name == "LSP" then
									local color_item = require("nvim-highlight-colors").format(
										ctx.item.documentation,
										{ kind = ctx.kind }
									)
									if color_item and color_item.abbr_hl_group then
										highlight = color_item.abbr_hl_group
									end
								end
								return highlight
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true } },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
			providers = {
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					opts = {
						prefix_min_len = 3,
						backend = {
							context_size = 5,
							ripgrep = {
								max_filesize = "1M",
								additional_rg_options = {},
							},
						},
					},
					transform_items = function(_, items)
						for _, item in ipairs(items) do
							item.kind_name = "Ripgrep"
						end
						return items
					end,
				},
			},
		},
		-- fuzzy = { implementation = "prefer_rust_with_warning" },
		fuzzy = { implementation = "lua" },
	})

	-- :config snippets
	require("luasnip.loaders.from_vscode").lazy_load()
	-- :config custom snippets
	local lpath = vim.fn.stdpath("config") .. "/snippets"
	require("luasnip.loaders.from_vscode").lazy_load({ paths = lpath })
	require("luasnip.loaders.from_vscode").load({ paths = lpath })
end)
