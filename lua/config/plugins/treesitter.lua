return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  --  branch="main",
  build = ":TSUpdate",

  config = function()
    require "nvim-treesitter.configs".setup {
      ensure_installed = { "lua", "c", "rust", "java", "perl", "haskell" },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
