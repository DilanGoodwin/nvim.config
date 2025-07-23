return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig

  config = function()
    require('render-markdown').setup({
      completion = { blink = { enabled = true } },
    })
  end,
}
