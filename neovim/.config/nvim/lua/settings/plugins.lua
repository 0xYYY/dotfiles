-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugin specs
local ui = {
    {
        "svrana/neosolarized.nvim",
        lazy = false,
        dependencies = {
            "tjdevries/colorbuddy.nvim",
        },
    },
    "kyazdani42/nvim-web-devicons",
    "norcalli/nvim-colorizer.lua",
    "romgrk/barbar.nvim",
    "nvim-lualine/lualine.nvim",
    "lewis6991/gitsigns.nvim",
    "kyazdani42/nvim-tree.lua",
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "folke/trouble.nvim",
    "karb94/neoscroll.nvim",
    "j-hui/fidget.nvim",
}

local language = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim",
    "glepnir/lspsaga.nvim",
    "lukas-reineke/lsp-format.nvim",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "folke/lsp-colors.nvim",
    "simrat39/symbols-outline.nvim",
    "simrat39/rust-tools.nvim",
    "TovarishFin/vim-solidity",
}

local completion = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "ray-x/cmp-treesitter",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
}

local editing = {
    "ggandor/leap.nvim",
    "kylechui/nvim-surround",
    {
        'numToStr/Comment.nvim',
        lazy = false,
    },
    "folke/todo-comments.nvim",
    "edluffy/specs.nvim",
}

local utils = {
    "nvim-lua/plenary.nvim",
    "nathom/filetype.nvim",
    "aserowy/tmux.nvim",
    "roxma/vim-tmux-clipboard",
    "ellisonleao/carbon-now.nvim",
    "tpope/vim-repeat",
}

-- set up plugins
local plugins = {}
for _, set in ipairs({ ui, language, completion, editing, utils }) do
    for _, plugin in ipairs(set) do
        table.insert(plugins, plugin)
    end
end
require("lazy").setup(plugins)
