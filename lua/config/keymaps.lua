vim.g.mapleader = " "

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>fd", telescope.find_files)
vim.keymap.set("n", "<leader>fh", telescope.help_tags)

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)  -- Add File
vim.keymap.set("n", "<leader>sl", function() harpoon:list():next() end) -- Next File
vim.keymap.set("n", "<leader>sh", function() harpoon:list():prev() end) -- Prev File

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Custom Scripts
vim.keymap.set("n", "<leader>fl", function()
  require('config.telescope.function_filter').treesitter_query(
    require("telescope.themes").get_ivy({ preview_width = "0.7" })
  )
end)
