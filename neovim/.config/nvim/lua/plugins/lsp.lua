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
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.ruff,
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
-- hack to modify winbar colors
local kind = require("lspsaga.lspkind")
kind[1][3] = colors.base1
kind[2][3] = colors.blue
kind[3][3] = colors.orange
kind[4][3] = colors.violet
kind[5][3] = colors.violet
kind[6][3] = colors.violet
kind[7][3] = colors.cyan
kind[8][3] = colors.cyan
kind[9][3] = colors.blue
kind[10][3] = colors.green
kind[11][3] = colors.orange
kind[12][3] = colors.violet
kind[13][3] = colors.blue
kind[14][3] = colors.cyan
kind[15][3] = colors.green
kind[16][3] = colors.green
kind[17][3] = colors.orange
kind[18][3] = colors.blue
kind[19][3] = colors.orange
kind[20][3] = colors.red
kind[21][3] = colors.red
kind[22][3] = colors.green
kind[23][3] = colors.violet
kind[24][3] = colors.violet
kind[25][3] = colors.green
kind[26][3] = colors.green
kind[252][3] = colors.green
kind[253][3] = colors.blue
kind[254][3] = colors.orange
kind[255][3] = colors.red

kind[1][2] = " "
kind[2][2] = " "
kind[3][2] = " "
kind[4][2] = " "
kind[5][2] = " "
kind[6][2] = " "
kind[7][2] = " "
kind[8][2] = " "
kind[9][2] = " "
kind[10][2] = " "
kind[11][2] = " "
kind[12][2] = " "
kind[13][2] = " "
kind[14][2] = " "
kind[15][2] = " "
kind[16][2] = " "
kind[17][2] = " "
kind[18][2] = " "
kind[19][2] = " "
kind[20][2] = " "
kind[21][2] = "ﳠ "
kind[22][2] = " "
kind[23][2] = "פּ "
kind[24][2] = " "
kind[25][2] = ""
kind[26][2] = " "

local saga = require("lspsaga")
saga.init_lsp_saga({
    border_style = "double",
    saga_winblend = 10,
    diagnostic_header = { " ", " ", " ", " " },
    code_action_icon = " ",
    symbol_in_winbar = {
        in_custom = false,
        enable = true,
        separator = "  ",
        show_file = true,
        click_support = false,
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
