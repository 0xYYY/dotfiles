local cmp = require("cmp")
local luasnip = require("luasnip")
local WIDE_HEIGHT = 40

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "treesitter" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)
            require("luasnip").lsp_expand(args.body) -- For luasnip users.
        end,
    },
    completion = {
        keyword_length = 2,
    },
    -- mapping = {
    --  ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
    --  ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
    --  ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    --  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    --  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    --  ["<C-y>"] = cmp.config.disable,
    --  ["<C-e>"] = cmp.mapping({
    --   i = cmp.mapping.abort(),
    --   c = cmp.mapping.close(),
    --  }),
    --  ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set select to false to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    window = {
        documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
            maxwidth = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
            maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
        },
    },
    formatting = {
        -- fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            local cmp_kinds = {
                Text = " ",
                Method = " ",
                Function = "",
                Constructor = " ",
                Field = " ",
                Variable = "",
                Class = " ",
                Interface = " ",
                Module = "",
                Property = " ",
                Unit = " ",
                Value = " ",
                Enum = " ",
                Keyword = " ",
                Snippet = " ",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                EnumMember = " ",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = " ",
                TypeParameter = " ",
            }
            vim_item.kind = (cmp_kinds[vim_item.kind] or "")
            vim_item.menu = (
                ({
                    buffer = " ",
                    nvim_lsp = "",
                    treesitter = "",
                    vsnip = "",
                    path = "",
                })[entry.source.name] or ""
                )
            return vim_item
        end,
    },
})

-- Use buffer source for '/' (if you enabled native_menu, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled native_menu, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Highlight Group
vim.cmd("autocmd VimEnter * highlight Pmenu guifg=#073642 guibg=#002b36")
vim.cmd("autocmd VimEnter * highlight PmenuSel guifg=#002b36 guibg=#b58900")
vim.cmd("autocmd VimEnter * highlight PmenuSbar guifg=#073642 guibg=#002b36")
vim.cmd("autocmd VimEnter * highlight PmenuThumb guifg=#586e75 guibg=#002b36")

vim.cmd("autocmd VimEnter * highlight CmpItemAbbr guifg=#073642 guibg=#839496")
vim.cmd("autocmd VimEnter * highlight CmpItemKind guifg=#073642 guibg=#2aa198")
vim.cmd("autocmd VimEnter * highlight CmpItemMenu guifg=#073642 guibg=#657b83")
vim.cmd("autocmd VimEnter * highlight CmpItemAbbrMatch guifg=#073642 guibg=#268bd2")
vim.cmd("autocmd VimEnter * highlight CmpItemAbbrMatchFuzzy guifg=#073642 guibg=#268bd2")

-- LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()
