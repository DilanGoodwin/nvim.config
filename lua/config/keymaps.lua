-- Clear Search Buffer
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ilter [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Teelescope Custom
local telescope_dropdown = require('telescope.themes').get_dropdown({
  winblend = 10,
  previewer = false,
})
vim.keymap.set('n', '<leader>/', function() builtin.current_buffer_fuzzy_find(telescope_dropdown) end,
  { desc = '[/] Fuzzy search current buffer' })

-- Harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd' })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = '[H]arpoon [N]ext' })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = '[H]arpoon [P]revious' })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = 'Harpoon List [Ctrl-e]' })

-- Undotree
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = '[U]ndotree [T]oggle' })

-- Custom Scripts
-- local grep_dir = require("config.telescope.multigrep")
-- local file_filters = require("config.telescope.function_filter")
-- local treesitter_theme = require("telescope.themes").get_ivy({ preview_width = "0.7" })
--
-- vim.keymap.set("n", "<leader>fg", function() grep_dir.LiveMultiGrep(treesitter_theme) end)
--
-- vim.keymap.set("n", "<leader>fl", function() file_filters.lang_keypoints_gen(treesitter_theme) end)
-- vim.keymap.set("n", "<leader>fc", function() file_filters.filter_node_text(treesitter_theme) end)
