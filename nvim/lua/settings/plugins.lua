-- Automatically run :PackerCompile whenever this file is updated
-- vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

local init = {
    "wbthomason/packer.nvim",
}

local ui = {
    "overcache/NeoSolarized",
    "kyazdani42/nvim-web-devicons",
    "norcalli/nvim-colorizer.lua",
    "romgrk/barbar.nvim",
    "NTBBloodbath/galaxyline.nvim",
    "lewis6991/gitsigns.nvim",
    "kyazdani42/nvim-tree.lua",
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    "folke/trouble.nvim",
    "karb94/neoscroll.nvim",
}

local language = {
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },
    "neovim/nvim-lspconfig",
    "onsails/lspkind-nvim",
    "folke/lsp-colors.nvim",
    "simrat39/symbols-outline.nvim",
    "simrat39/rust-tools.nvim",
    "TovarishFin/vim-solidity",
}

local completion = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-vsnip",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
}

local editing = {
    "easymotion/vim-easymotion",
    "b3nj5m1n/kommentary",
    "folke/todo-comments.nvim",
    "windwp/nvim-autopairs",
    "mhartington/formatter.nvim",
}

local utils = {
    "aserowy/tmux.nvim",
    "roxma/vim-tmux-clipboard",
    -- required by gitsigns, todo-comments, telescope
    "nvim-lua/plenary.nvim",
}

-- Settings that need to go before loading the plugin
-- kommentary
vim.g.kommentary_create_default_mappings = false

local packer = require("packer")
local plugins = {}
for _, set in pairs({ init, ui, language, completion, editing, utils }) do
    for _, plugin in ipairs(set) do
        table.insert(plugins, plugin)
    end
end
packer.startup({
    plugins,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})
