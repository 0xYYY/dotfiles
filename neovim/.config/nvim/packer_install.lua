vim.cmd([[autocmd User PackerComplete quitall]])
require("settings.plugins")
require("packer").sync()
