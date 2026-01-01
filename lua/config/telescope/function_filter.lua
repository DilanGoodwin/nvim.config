local treesitter = vim.treesitter
local tel_config = require('telescope.config').values
local tel_picker = require('telescope.pickers')
local tel_finder = require('telescope.finders')
local tel_entry = require('telescope.make_entry')

local lang_keypoints_queries = {
  ["c"] = [[
    (function_definition(pointer_declarator(function_declarator(identifier) @name )*)*
    (function_declarator(identifier) @name )*)

    (preproc_function_def(identifier) @name )

    (enum_specifier !name) @name
    (enum_specifier name : (type_identifier) @name)

    (type_definition declarator : (type_identifier) @name )
    (struct_specifier name:(type_identifier) @name body:(field_declaration_list))
    ]],
  ["java"] = [[
    (class_declaration name:(identifier) @name)

    (method_declaration name:(identifier) @name)

    (enum_declaration name:(identifier) @name)
    ]],
  ["python"] = [[
    (function_definition name:(identifier) @name)
    ]],
  ["lua"] = [[
    (assignment_statement(variable_list
      name: [ (identifier)(dot_index_expression)] @name
      )(expression_list (function_definition)))
    ]],
  ["markdown"] = [[
    (atx_heading) @name
  ]],
  ["bash"] = [[
    (function_definition name:(word) @name)
  ]],
  ["perl"] = [[
    (subroutine_declaration_statement name:(bareword) @name)
  ]],
}

local M = {}

local cur_buf = vim.api.nvim_get_current_buf()

local table_length = function(table_item)
  local count = 0
  for _, _ in pairs(table_item) do count = count + 1 end
  return count
end

local get_language = function()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = cur_buf })
  local language = treesitter.language.get_lang(filetype)

  return language
end

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

M.lang_keypoints_gen = function(opts)
  local language = get_language()
  if language == nil then
    print("ERROR: Detecting Language")
    return
  end

  local retrieved_query = lang_keypoints_queries[language]
  if retrieved_query == nil then
    print("ERROR: Finding Query - Language: " .. language)
    return
  end

  local found_items = filter_tree(language, retrieved_query)
  if table_length(found_items) == 0 then
    print("ERROR: No Items Found - Language: " .. language)
    return
  end

  -- telescope_window(opts, found_items)
  tel_picker.new(opts, {
    prompt_title = 'Filter',
    finder = tel_finder.new_table({
      results = found_items,
      entry_maker = tel_entry.gen_from_treesitter(opts),
    }),
    previewer = tel_config.qflist_previewer(opts),
    sorter = tel_config.generic_sorter(),
  }):find()
end

return M
