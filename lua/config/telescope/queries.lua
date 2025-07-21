local query_list = {
  ["c"] = [[
    (function_definition(pointer_declarator(function_declarator(identifier) @name )*)*
    (function_declarator(identifier) @name )*)
    (enum_specifier(type_identifier) @name )
    (type_definition(struct_specifier(type_identifier) @name ))
    ]],
}

M = {}

M.get_query = function(language)
  return query_list[language]
end

return M
