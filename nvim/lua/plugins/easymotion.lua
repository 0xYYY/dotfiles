local utils = require("utils")

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_keys = "ASDFGHJKL;QWERUIOPZXCVM,./"
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_upper = 1

utils.map("n", "<Leader>", "<Plug>(easymotion-prefix)", { noremap = false })
utils.map("v", "<Leader>", "<Plug>(easymotion-prefix)", { noremap = false })

-- Jump in current line
utils.map("n", "<Leader>l", "<Plug>(easymotion-lineanywhere)", { noremap = false })
utils.map("v", "<Leader>l", "<Plug>(easymotion-lineanywhere)", { noremap = false })

-- Jump to any line (only current window in visual mode)
utils.map("n", "<Leader>j", "<Plug>(easymotion-overwin-line)", { noremap = false })
utils.map("v", "<Leader>j", "<Plug>(easymotion-bd-jk)", { noremap = false })

-- Jump to a character (only current window in visual mode)
utils.map("n", "<Leader>s", "<Plug>(easymotion-overwin-f)", { noremap = false })
utils.map("v", "<Leader>s", "<Plug>(easymotion-s)", { noremap = false })
