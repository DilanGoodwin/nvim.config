local treesitter = vim.treesitter
local tel_config = require('telescope.config').values
local tel_picker = require('telescope.pickers')
local tel_finder = require('telescope.finders')
local tel_entry = require('telescope.make_entry')
local query_file = require('config.telescope.queries')

local M = {}

local filter_tree = function(language, query)
  local tree = treesitter.get_parser():parse()[1]
  local results = treesitter.query.parse(language, query)
  local found_items = {}

  for _, matches, _ in results:iter_matches(tree:root(), 0) do
    for _, nodes in ipairs(matches) do
      for _, node in ipairs(nodes) do
        table.insert(found_items, { node = node, kind = language })
      end
    end
  end

  return found_items
end

local telescope_window = function(opts, filtered_items)
  opts = opts or {}

  -- Telescope Picker
  tel_picker.new(opts, {
    prompt_title = "Filter",
    finder = tel_finder.new_table({
      results = filtered_items,
      entry_maker = tel_entry.gen_from_treesitter(opts),
    }),
    previewer = tel_config.qflist_previewer(opts),
    sorter = tel_config.generic_sorter(),
  }):find()
end

M.setup = function()
end

M.treesitter_query = function(opts)
  local current_buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = current_buf })
  local language = treesitter.language.get_lang(filetype)

  -- ERROR Check - language checks to be moved into own function for grabbing query
  if language == nil then
    print("ERROR: Detecting Language")
    return
  end

  local retrieved_query = query_file.get_query(language)
  local found_items = filter_tree(language, retrieved_query)

  telescope_window(opts, found_items)
end

return M
