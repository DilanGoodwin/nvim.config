return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  --  branch="main",
  build = ":TSUpdate",

  config = function()
    require "nvim-treesitter".setup {
      ensure_installed = { "lua", "c", "rust", "java", "perl", "haskell" },
      auto_install = false,
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
