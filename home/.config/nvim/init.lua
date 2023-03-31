require("basic")
require("theme")
require("plugins")
-- lsp {{{
require("mason").setup({
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s"
    },
    ui = {check_outdated_packages_on_open = true}
})

require("mason-lspconfig").setup({automatic_installation = true})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {capabilities = capabilities}
    end
})
require("mason-null-ls").setup({
    automatic_installation = true,
    automatic_setup = true
})

require("lsp_signature").setup()
-- }}}
-- completion {{{
local luasnip = require("luasnip")
local cmp = require("cmp")
require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    sources = {
        {name = "nvim_lsp"}, {name = "path"}, {name = "cmdline"},
        {name = "luasnip"}
    }
})

cmp.setup.cmdline({'/', '?'}, {
    sources = {{name = 'buffer'}}
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
-- }}}
