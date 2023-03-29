require('lualine').setup {
  options = {
    theme = 'auto'
  }
}
local time = os.date('%H', os.time()) + 0
if time >= 13 then
    require('onedark').setup {
      style = 'darker'
   }
elseif time >= 10 then
   require('onedark').setup {}
elseif time >= 0 then
    require('onedark').setup {}
end
require('onedark').load()
require("nvim-tree").setup()
