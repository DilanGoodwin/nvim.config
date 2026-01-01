return {
  'nvim-telescope/telescope.nvim',
  tag = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',            enabled = true },
  },

  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          layout_config = { preview_width = 0.65 },
        },
        diagnostics = { theme = 'ivy' },
      },
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown(), },
        fzf = {}
      },
      defaults = {
        bottom_pane = { height = 10 },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
          }
        }
      }
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    require('config.telescope.multigrep').setup()
  end,
}
