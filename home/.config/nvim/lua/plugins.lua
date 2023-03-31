vim.cmd("packadd packer.nvim")
local packer = require("packer")
packer.init {
    display = {compact = true},
    git = {default_url_format = "https://githubfast.com/%s.git"}
}

packer.startup(function(use)
    use "nvim-tree/nvim-web-devicons"
    use "nvim-lualine/lualine.nvim"
    use "navarasu/onedark.nvim"
    use {"nvim-tree/nvim-tree.lua", run = ":TSUpdate"}
    use "neovim/nvim-lspconfig"
    use {"williamboman/mason.nvim", run = ":MasonUpdate"}
    use "nvim-lua/plenary.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "antoinemadec/FixCursorHold.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jay-babu/mason-null-ls.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "windwp/nvim-autopairs"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"
    use "ray-x/lsp_signature.nvim"
    use {
        "nvim-neotest/neotest",
        requires = {
            "vim-test/vim-test", "nvim-neotest/neotest-vim-test",
            "nvim-neotest/neotest-python"
        }
    }
    use {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup() end
    }
    use "nvim-telescope/telescope.nvim"
end)
