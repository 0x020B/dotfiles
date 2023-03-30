-- basic {{{
vim.o.bk = true
vim.o.cuc = true
vim.o.cul = true
vim.o.fdc = "auto"
vim.o.fdm = "indent"
vim.o.ic = true
vim.o.nu = true
vim.o.rnu = true
vim.o.sh = "/usr/bin/zsh"
vim.o.so = 5
vim.o.si = true
vim.o.wic = true
vim.g.load_netrw = 1
vim.g.load_netrwPlugin = 1
vim.o.termguicolors = true
-- }}}
-- theme {{{
require('lualine').setup {options = {theme = 'auto'}}
local time = os.date('%H', os.time()) + 0
if time >= 13 then
    require('onedark').setup {style = 'darker'}
elseif time >= 10 then
    require('onedark').setup {}
elseif time >= 0 then
    require('onedark').setup {}
end
require('onedark').load()
require("nvim-tree").setup()
-- }}}
-- plugins {{{
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
-- }}}
-- lsp {{{
require('mason').setup {
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s"
    },
    ui = {check_outdated_packages_on_open = true}
}

require('mason-lspconfig').setup {automatic_installation = true}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {capabilities = capabilities}
    end
}

require('mason-null-ls').setup {
    automatic_installation = true,
    automatic_setup = true
}

require('mason-null-ls').setup_handlers()

require('lsp_signature').setup {}
-- }}}
-- completion {{{
local luasnip = require 'luasnip'

local cmp = require 'cmp'
cmp.setup {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
}
-- }}}
-- Vim: set foldmethod=marker:
