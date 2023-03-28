local packer = require('packer')
packer.init {
    display = {
        compact = true
    },
    git = {
    default_url_format = 'https://githubfast.com/%s.git'
    }
}
packer.startup(function(use)
    use 'neovim/nvim-lspconfig'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate"
    }
    use "williamboman/mason-lspconfig.nvim"
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
end)
