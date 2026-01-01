return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    require('nvim-treesitter.config').setup({
      install_dir = vim.fn.stdpath('data') .. '/site',
      ensure_installed = {'lua', 'c', 'rust', 'java', 'perl', 'haskell'},
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })
  end,
}
