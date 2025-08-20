vim.g.mapleader = " "

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
  { noremap = true })
vim.keymap.set("n", "<leader>fh", telescope.help_tags)

-- Harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)  -- Add File
vim.keymap.set("n", "<leader>sl", function() harpoon:list():next() end) -- Next File
vim.keymap.set("n", "<leader>sh", function() harpoon:list():prev() end) -- Prev File

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Custom Scripts
local grep_dir = require("config.telescope.multigrep")
local file_filters = require("config.telescope.function_filter")
local treesitter_theme = require("telescope.themes").get_ivy({ preview_width = "0.7" })

vim.keymap.set("n", "<leader>fg", function() grep_dir.LiveMultiGrep(treesitter_theme) end)

vim.keymap.set("n", "<leader>fl", function() file_filters.lang_keypoints_gen(treesitter_theme) end)
vim.keymap.set("n", "<leader>fc", function() file_filters.filter_node_text(treesitter_theme) end)
