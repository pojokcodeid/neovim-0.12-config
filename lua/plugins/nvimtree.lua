On_event({ "VimEnter" }, function()
	vim.pack.add({
		{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
		{ src = "https://github.com/kyazdani42/nvim-web-devicons" },
	})

	-- for fix error last close buffer
	vim.api.nvim_create_autocmd({ "QuitPre" }, {
		callback = function()
			vim.cmd("NvimTreeClose")
		end,
	})

	local icons = require("icons")
	local opts = {}
	opts.auto_reload_on_write = false
	opts.disable_netrw = false
	opts.hijack_cursor = false
	opts.hijack_netrw = true
	opts.hijack_unnamed_buffer_when_opening = false
	opts.sync_root_with_cwd = true
	opts.sort = {
		sorter = "name",
		folders_first = true,
		files_first = false,
	}
	opts.root_dirs = {}
	opts.prefer_startup_root = false
	opts.sync_root_with_cwd = true
	opts.reload_on_bufenter = false
	opts.respect_buf_cwd = false
	opts.on_attach = "default"
	opts.select_prompts = false
	opts.update_focused_file = {
		enable = true,
		update_root = false,
	}
	opts.view = {
		adaptive_size = false,
		centralize_selection = true,
		width = 30,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	}
	opts.renderer = {
		root_folder_label = false,
		highlight_git = true,
		indent_markers = { enable = false },
		-- indent_markers = {
		--		enable = true,
		--		inline_arrows = true,
		--		icons = {
		--			corner = "└",
		--			edge = "│",
		--			item = "│",
		--			none = " ",
		--		},
		--	},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = icons.ui.Text,
				symlink = icons.ui.FileSymlink,
				bookmark = icons.ui.BookMark,
				--[[  folder = {
              arrow_closed = icons.ui.ChevronShortRight,
              arrow_open = icons.ui.ChevronShortDown,
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.FolderSymlink,
              symlink_open = icons.ui.FolderOpen,
            }, ]]
				folder = {
					arrow_closed = icons.ui.TriangleShortArrowRight,
					arrow_open = icons.ui.TriangleShortArrowDown,
					default = icons.ui.Folder,
					open = icons.ui.FolderOpen,
					empty = icons.ui.EmptyFolder,
					empty_open = icons.ui.EmptyFolderOpen,
					symlink = icons.ui.FolderSymlink,
					symlink_open = icons.ui.FolderOpen,
				},
				git = {
					unstaged = icons.git.FileUnstaged,
					staged = icons.git.FileStaged,
					unmerged = icons.git.FileUnmerged,
					renamed = icons.git.FileRenamed,
					untracked = icons.git.FileUntracked,
					deleted = icons.git.FileDeleted,
					ignored = icons.git.FileIgnored,
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
	}
	opts.filters = {
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		custom = { "node_modules", "\\.cache", "\\.git" },
		exclude = {
			".gitignore",
			".prettierignore",
		},
	}
	opts.notify = {
		threshold = vim.log.levels.INFO,
	}
	opts.git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
		disable_for_dirs = {},
		timeout = 400,
	}
	require("nvim-tree").setup(opts)
	local api = require("nvim-tree.api")
	api.events.subscribe(api.events.Event.FileCreated, function(file)
		vim.cmd("edit " .. file.fname)
	end)

	vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "Explorer" })
end)
