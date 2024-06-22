local configure_lsp_zero = function()
	local lsp_zero = require("lsp-zero")
	local mason = require("mason")
	local mason_lsp_config = require("mason-lspconfig")
	local lspconfig = require("lspconfig")
	local null_ls = require("null-ls")
	local cmp = require("cmp")

	local ensured_lang_servers = {
		-- defaults
		"bashls",
		"vimls",
		"lua_ls",
		"gopls",
	}

	local ls_handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			lspconfig.lua_ls.setup(lua_opts)
		end,
	}

	local null_ls_sources = {
		null_ls.builtins.formatting.stylua,
	}

	local sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "»",
	}

	local set_keymaps = function(bufnr)
		local opts = { buffer = bufnr }

		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps(opts)

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
		end, opts)
	end

	-- run mason setup
	mason.setup({})
	mason_lsp_config.setup({
		ensure_installed = ensured_lang_servers,
		handlers = ls_handlers,
	})

	-- run nls setup
	null_ls.setup({
		sources = null_ls_sources,
	})

	-- run cmp setup
	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
		},

		preselect = "none",
		completion = {
			completeopt = "menu,menuone,noinsert,noselect",
		},

		mapping = cmp.mapping.preset.insert({
			["<C-j>"] = lsp_zero.cmp_action().luasnip_jump_forward(),
			["<C-k>"] = lsp_zero.cmp_action().luasnip_jump_backward(),
			["<C-Space>"] = lsp_zero.cmp_action().luasnip_supertab(),
		}),

		formatting = {
			-- changing the order of fields so the icon is the first
			fields = { "menu", "abbr", "kind" },

			-- here is where the change happens
			format = function(entry, item)
				local menu_icon = {
					nvim_lsp = "λ",
					luasnip = "⋗",
					buffer = "Ω",
					path = "🖫",
					nvim_lua = "Π",
				}

				item.menu = menu_icon[entry.source.name]
				return item
			end,
		},
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline" },
		}),
	})

	-- lsp zero config
	lsp_zero.on_attach(function(_, bufnr)
		set_keymaps(bufnr)
		lsp_zero.set_sign_icons(sign_icons)
		lsp_zero.buffer_autoformat()
	end)
end

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = { "neovim/nvim-lspconfig" },
		config = configure_lsp_zero,
	},
}
