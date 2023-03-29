local packer = require('packer')
packer.init {
    display = {compact = true},
    git = {default_url_format = 'https://githubfast.com/%s.git'}
}

packer.startup(function(use)
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use 'navarasu/onedark.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim', run = ":MasonUpdate"}
    use 'nvim-lua/plenary.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'ray-x/lsp_signature.nvim'
    use {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup {} end
    }
    use 'nvim-telescope/telescope.nvim'
end)
