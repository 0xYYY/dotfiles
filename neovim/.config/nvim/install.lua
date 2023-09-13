vim.cmd([[autocmd User PackerComplete quitall]])
require("settings.plugins")
require("Lazy").sync()
