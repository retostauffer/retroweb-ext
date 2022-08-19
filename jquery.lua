

-- Simply includes jquery-*.min.js dependency
local function ensureHtmlDeps()
    print("[Retroweb]: Adding jQuery 3.6.0")
    quarto.doc.addHtmlDependency({
        name = "jquery",
        version = "3.6.0",
        scripts = {"assets/jquery-3.6.0.min.js"}
    })
end

-- Test shortcode
return {
    {Pandoc = ensureHtmlDeps()},
}
