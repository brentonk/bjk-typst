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
