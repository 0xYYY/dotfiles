local utils = require("utils")
local colors = require("colors")

local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")

local on_attach = function(client, bufnr)
	-- Formatting
	require("lsp-format").on_attach(client)

	-- Mappings
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

-- Setup
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "bashls", "gopls", "pyright", require("rust-tools"), "sumneko_lua", "solidity_ls", "tsserver" }
for _, lsp in ipairs(servers) do
	local config = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	}
	if type(lsp) == "string" then
		-- lspconfig builtins
		lsp = nvim_lsp[lsp]
		if lsp == "sumneko_lua" then
			config.settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			}
		end
	else
		-- rust-tools
		config = { server = config }
	end
	lsp.setup(config)
end

-- null-ls
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "solidity", "toml", "html" },
			extra_args = { "--tab-width", "4" },
		}),
		-- python
		-- null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.mypy,
		-- go
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.diagnostics.golangci_lint,
		-- bash
		null_ls.builtins.formatting.shfmt.with({
			extra_args = { "--indent", "4" },
		}),
		null_ls.builtins.formatting.shellharden,
		-- lua
		null_ls.builtins.formatting.stylua,
	},
	on_attach = on_attach,
})

-- lsp_lines
-- require("lsp_lines").setup()
-- vim.keymap.set("", "<Leader>D", require("lsp_lines").toggle)
-- vim.diagnostic.config({ virtual_text = false, virtual_lines = { only_current_line = true } })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = colors.darken(colors.red, 0.2), fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = colors.darken(colors.yellow, 0.1), fg = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = colors.darken(colors.blue, 0.1), fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = colors.darken(colors.cyan, 0.1), fg = colors.cyan })

-- lsp-colors
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.cyan })
-- require("lsp-colors").setup({
-- 	Error = colors.red,
-- 	Warning = colors.yellow,
-- 	Information = colors.blue,
-- 	Hint = colors.cyan,
-- })

-- Signs
local signs = { Error = "", Warning = "", Information = "", Hint = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lspsaga
require("lspsaga").setup({
	ui = {
		border = "double",
		winblend = 10,
		diagnostic = { " ", " ", " ", " " },
		code_action = " ",
		colors = {
			red = colors.red,
			magenta = colors.magenta,
			orange = colors.orange,
			yellow = colors.yellow,
			green = colors.green,
			cyan = colors.cyan,
			blue = colors.blue,
			purple = colors.purple,
			white = colors.base3,
			black = colors.base02,
			gray = colors.base00,
			normal_bg = colors.base03,
			title_bg = colors.base00,
			fg = colors.base2,
		},
		kind = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = "ﳠ ",
			EnumMember = " ",
			Struct = "פּ ",
			Event = " ",
			Operator = "",
			TypeParameter = " ",
			TypeAlias = " ",
			Parameter = " ",
			StaticMethod = "ﴂ ",
			Macro = " ",
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = "  ",
		show_file = true,
	},
})

-- keymap
utils.map("n", "<Leader>d", "<cmd>Lspsaga preview_definition<CR>")
utils.map("n", "<Leader>h", "<Cmd>Lspsaga signature_help<CR>")
utils.map("n", "<Leader>H", "<cmd>Lspsaga hover_doc<CR>")
utils.map("n", "<Leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>")
utils.map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
utils.map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
utils.map("n", "<leader>r", "<cmd>Lspsaga rename<CR>")
utils.map("n", "<leader>a", "<cmd>Lspsaga code_action<CR>")
-- scroll up/down preview
-- local action = require("lspsaga.action")
-- vim.keymap.set("n", "<C-f>", function()
-- 	action.smart_scroll_with_saga(1)
-- end, { silent = true })
-- vim.keymap.set("n", "<C-b>", function()
-- 	action.smart_scroll_with_saga(-1)
-- end, { silent = true })

-- highlight
vim.api.nvim_set_hl(0, "LspSagaWinbarSep", { fg = colors.base00 })
local border_hl_groups = {
	"LspSagaDefPreviewBorder",
	"LspSagaSignatureHelpBorder",
	"LspSagaHoverBorder",
	"LspSagaDiagnosticBorder",
	"LspSagaRenameBorder",
	"LspSagaCodeActionBorder",
}
for _, g in pairs(border_hl_groups) do
	vim.api.nvim_set_hl(0, g, { fg = colors.base00 })
end
local line_hl_groups = {

	"LspSagaShTrunCateLine",
	"LspSagaHoverTrunCateLine",
	"LspSagaDiagnosticTruncateLine",
	"LspSagaErrorTrunCateLine",
	"LspSagaWarnTrunCateLine",
	"LspSagaInfoTrunCateLine",
	"LspSagaHintTrunCateLine",
	"LspSagaCodeActionTrunCateLine",
}
for _, g in pairs(line_hl_groups) do
	vim.api.nvim_set_hl(0, g, { fg = colors.base00 })
end
local title_hl_groups = {
	"DefinitionPreviewTitle",
	"LspSagaDiagnosticHeader",
	"LspSagaCodeActionTitle",
}
for _, g in pairs(title_hl_groups) do
	vim.api.nvim_set_hl(0, g, { fg = colors.blue, bold = true })
end
vim.api.nvim_set_hl(0, "LspSagaCodeActionContent", { fg = colors.base2 })
