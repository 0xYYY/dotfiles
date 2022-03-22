local cmd = vim.cmd
local utils = require("utils")
local colors = require("colors")
local nvim_lsp = require("lspconfig")

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

local on_attach = function(client, bufnr)
    -- Mappings
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "<Leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<Leader>H", "<cmd><cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Border
local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Signs
local signs = { Error = "", Warning = "", Hint = "", Information = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup
local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
local servers = { "gopls", "tsserver", "pyright", "bashls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
end
require("rust-tools").setup({ server = { on_attach = on_attach, capabilities = capabilities } })

-- lspkind
require("lspkind").init({
    mode = "symbol",
    symbol_map = {
        File = "",
        Module = "",
        Class = "ﴯ",
        Method = "",
        Property = "",
        Field = "ﰠ",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Interface = "",
        Function = "",
        Variable = "",
        Folder = "",
        Constant = "",
        Text = "",
        Unit = "塞",
        Keyword = "",
        Value = "",
        Snippet = "",
        Color = "",
        Reference = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = "𝙏",
    },
})

-- lso-colors
-- NeoVim 0.6 breaks this plugin, ref: https://github.com/folke/lsp-colors.nvim/issues/13
-- require("lsp-colors").setup({
--     Error = colors.red,
--     Warning = colors.yellow,
--     Information = colors.blue,
--     Hint = colors.cyan,
-- })

cmd("hi DiagnosticError ctermbg=NONE ctermfg=NONE guibg=NONE guifg=" .. colors.red)
cmd("hi DiagnosticWarn ctermbg=NONE ctermfg=NONE guibg=NONE guifg=" .. colors.yellow)
cmd("hi DiagnosticInfo ctermbg=NONE ctermfg=NONE guibg=NONE guifg=" .. colors.blue)
cmd("hi DiagnosticHint ctermbg=NONE ctermfg=NONE guibg=NONE guifg=" .. colors.cyan)
