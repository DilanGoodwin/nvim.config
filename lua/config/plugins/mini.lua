return {
  "echasnovski/mini.nvim",
  enabled = true,
  config = function()
    require("mini.icons").setup()
    require("mini.doc").setup()

    local statusline = require "mini.statusline"
    statusline.setup { use_icons = true }
  end
}
