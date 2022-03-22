require("neoscroll").setup({
    hide_cursor = true, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil, -- Default easing function
    pre_hook = nil, -- Function to run before the scrolling animation starts
    post_hook = nil, -- Function to run after the scrolling animation ends
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "100" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "100" } }
t["<C-y>"] = { "scroll", { "-0.10", "false", "50" } }
t["<C-e>"] = { "scroll", { "0.10", "false", "50" } }
t["zt"] = { "zt", { "100" } }
t["zz"] = { "zz", { "100" } }
t["zb"] = { "zb", { "100" } }

require("neoscroll.config").set_mappings(t)
