return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
  },

  config = function()
    require("telescope").setup({
      pickers = {
        find_files = { theme = "ivy" }
      },
      extensions = {
        fzf = {}
      },
      defaults = {
        layout_config = {
          bottom_pane = { preview_width = 0.7 }
        },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
          }
        }
      }
    })

    require("telescope").load_extension("fzf")
    require("config.telescope.multigrep").setup()
    require("config.telescope.function_filter").setup()
  end
}
