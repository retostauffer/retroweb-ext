

-- Simply includes jquery-*.min.js dependency
local function ensureHtmlDeps()
    -- print("[Rotorweb] Adding jQuery 3.6.0")
    quarto.doc.addHtmlDependency({
        name = "jquery",
        version = "3.6.0",
        scripts = {"js/rotorweb-bundle.min.js"}
        --scripts = {"node_modules/jquery/dist/jquery.min.js"}
    })
end

-- Test shortcode
return {
    {Pandoc = ensureHtmlDeps()},
}
