local utils = require("utils")

utils.map("n", "<Leader>c", "<Plug>kommentary_line_default", { noremap = false })
utils.map("x", "<Leader>c", "<Plug>kommentary_visual_default<C-c>", { noremap = false })

utils.map("n", "<Leader>cy", "Y<Plug>kommentary_line_default", { noremap = false })
utils.map("x", "<Leader>cy", "ygv<Plug>kommentary_visual_default<C-c>`>", { noremap = false })

utils.map("n", "<Leader>cp", "Y<Plug>kommentary_line_defaultp", { noremap = false })
utils.map("x", "<Leader>cp", "ygv<Plug>kommentary_visual_default<C-c>`>p", { noremap = false })

require("kommentary.config").configure_language("default", {
	prefer_single_line_comments = true,
})
