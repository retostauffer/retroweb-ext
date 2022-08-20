
local function include_fa_functions()
    -- quarto.doc.includeText("in-header", res)
    quarto.doc.includeFile("in-header", "scripts/fa.html")
end

return {{
    Meta = include_fa_functions
}}

