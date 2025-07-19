local treesitter = vim.treesitter

local M = {}

local query = [[
(function_definition
(pointer_declarator (function_declarator (identifier) @name )*)*
(function_declarator (identifier) @name )*
)
]]

local printer = function(value)
  print(vim.inspect(value))
end

local filter_tree = function()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  local tree = treesitter.get_parser():parse()[1]

  -- ERROR Check - language checks to be moved into own function for grabbing query
  local language = treesitter.language.get_lang(filetype)
  if language == nil then
    print("ERROR Detecting Language")
    return nil
  end

  local results = treesitter.query.parse(language, query)
  local found_functions = {}
  local iter = 0

  for _, matches, _ in results:iter_matches(tree:root(), 0) do
    for _, nodes in ipairs(matches) do
      for _, node in ipairs(nodes) do
        found_functions[iter] = node
        iter = iter + 1
      end
    end
  end

  return found_functions
end

local testing_function = function()
  local found_names = filter_tree()

  local string_to_print = "Functions: "

  for i = 0, #found_names do
    string_to_print = string_to_print .. treesitter.get_node_text(found_names[i], 0) .. ','
  end

  printer(string_to_print)
end

M.setup = function()
  vim.keymap.set("n", "<leader>fl", testing_function)
end

return M
