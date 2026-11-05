function appendix(args, kwargs)
    local params = {}
    for k, v in pairs(kwargs) do
        table.insert(params, k .. ': ' .. pandoc.utils.stringify(v))
    end
    if #params > 0 then
        return pandoc.RawBlock('typst', '#show: appendix.with(' .. table.concat(params, ', ') .. ')')
    else
        return pandoc.RawBlock('typst', '#show: appendix')
    end
end

-- {{< indent >}}: manual first-line indent for a new paragraph that Typst
-- leaves flush left (e.g. right after a list or display equation). See the
-- `indent` macro in macros.typ. Emits nothing in non-Typst formats.
function indent(args, kwargs)
    if quarto.doc.is_format('typst') then
        return pandoc.RawInline('typst', '#indent')
    end
    return pandoc.Inlines({})
end
