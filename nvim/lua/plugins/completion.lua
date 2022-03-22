local cmd = vim.cmd
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local lspkind = require("lspkind")
local WIDE_HEIGHT = 40

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "treesitter" },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    completion = {
        keyword_length = 2,
    },
    formatting = {
        -- fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            with_text = false,
            menu = {
                buffer = "﬘",
                nvim_lsp = "突",
                treesitter = "",
                vsnip = "",
                path = "",
            },
        }),
    },
    documentation = {
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
        maxwidth = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
        maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
    },
    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.config.disable,
    },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Highlight Group
cmd("autocmd VimEnter * highlight Pmenu guifg=#073642 guibg=#002b36")
cmd("autocmd VimEnter * highlight PmenuSel guifg=#002b36 guibg=#b58900")
cmd("autocmd VimEnter * highlight PmenuSbar guifg=#073642 guibg=#002b36")
cmd("autocmd VimEnter * highlight PmenuThumb guifg=#586e75 guibg=#002b36")

cmd("autocmd VimEnter * highlight CmpItemAbbr guifg=#073642 guibg=#839496")
cmd("autocmd VimEnter * highlight CmpItemKind guifg=#073642 guibg=#2aa198")
cmd("autocmd VimEnter * highlight CmpItemMenu guifg=#073642 guibg=#657b83")
cmd("autocmd VimEnter * highlight CmpItemAbbrMatch guifg=#073642 guibg=#268bd2")
cmd("autocmd VimEnter * highlight CmpItemAbbrMatchFuzzy guifg=#073642 guibg=#268bd2")
