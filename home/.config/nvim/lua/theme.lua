require("lualine").setup({options = {theme = "auto"}})
local time = os.date("%H", os.time()) + 0
local theme_config = {
    transparent = true,
    ending_tildes = true,
    lualine = {transparent = true}
}
if time >= 13 then
    theme_config["style"] = "dark"
elseif time >= 10 then
    theme_config["style"] = "darker"
elseif time >= 6 then
    theme_config["style"] = "warmer"
elseif time >= 0 then
    theme_config["style"] = "cool"
end
require("onedark").setup(theme_config)
require("onedark").load()
require("nvim-treesitter.configs").setup({
    sync_install = true,
    auto_install = true,
    highlight = {enable = true, additional_vim_regex_highlighting = false}
})
require("nvim-tree").setup()
vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end
})
