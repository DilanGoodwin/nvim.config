vim.g.mapleader = " "

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>sl", function() harpoon:list():prev() end)
