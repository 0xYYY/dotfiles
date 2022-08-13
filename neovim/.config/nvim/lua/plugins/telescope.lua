local cmd = vim.cmd
local utils = require("utils")
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        sorting_strategy = "ascending",
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        entry_prefix = "  ",
        layout_strategy = "flex",
        layout_config = {
            prompt_position = "top",
            height = 0.8,
            width = 0.8,
            flex = {
                flip_columns = 140,
                horizontal = {
                    preview_cutoff = 140,
                    preview_width = 60,
                },
                vertical = {
                    preview_cutoff = 30,
                    preview_height = 10,
                },
            },
        },
        border = true,
        borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
        set_env = { ["COLORTERM"] = "truecolor" },
        winblend = 10,
        file_ignore_patterns = { "node_modules" },
    },
    i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-v>"] = actions.select_horizontal,
        ["<C-x>"] = actions.select_vertical,
    },
})

require("telescope").load_extension("fzf")

utils.map("n", "<Leader>fF", [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
utils.map("n", "<Leader>ff", [[<cmd>lua require('telescope.builtin').git_files()<cr>]])
utils.map("n", "<Leader>fS", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
utils.map(
    "n",
    "<Leader>fs",
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]]
)
utils.map("n", "<Leader>fr", [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]])

cmd([[autocmd VimEnter * highlight TelescopeBorder         guifg=#93a1a1]])
cmd([[autocmd VimEnter * highlight TelescopePromptBorder   guifg=#93a1a1]])
cmd([[autocmd VimEnter * highlight TelescopeResultsBorder  guifg=#93a1a1]])
cmd([[autocmd VimEnter * highlight TelescopePreviewBorder  guifg=#93a1a1]])
cmd([[autocmd VimEnter * highlight TelescopeMatching       guifg=#93a1a1]])
cmd([[autocmd VimEnter * highlight TelescopeSelection guifg=#b58900 gui=bold]])
