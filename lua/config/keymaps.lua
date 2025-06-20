vim.g.mapleader = " "

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
