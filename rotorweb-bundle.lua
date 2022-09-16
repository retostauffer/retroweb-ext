

-- Include js/rotorweb-bundle.js for additional
-- jQuery support plus custom functions for the
-- rotorweb theme.
local function ensureHtmlDeps()

    -- print("[Rotorweb] Adding rotorweb-bundle.js
    quarto.doc.addHtmlDependency({
        name = "rotorweb-bundle",
        scripts = {"dist/rotorweb-bundle.min.js"},
        resources = fonts
    })
end

return {
    {Pandoc = ensureHtmlDeps()},
}
