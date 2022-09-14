

-- Include js/rotorweb-bundle.js for additional
-- jQuery support plus custom functions for the
-- rotorweb theme.
local function ensureHtmlDeps()
    local resources = {
        "dist/10f04a362aa1808e9d09.ttf",
        "dist/5d864e61359057d77c6e.ttf",
        "dist/76b6aaddc77c20879b43.woff2",
        "dist/90706a1728517d1155cf.ttf",
        "dist/bc13c79bfd4c458df66d.ttf",
        "dist/c559d50d7f074d6b6ee4.woff2",
        "dist/e31903cebecf195d0334.woff2",
        "dist/ec7397548375672e2414.woff2",
        "dist/rotorweb-bundle.min.js"
    }
    -- print("[Rotorweb] Adding rotorweb-bundle.js
    quarto.doc.addHtmlDependency({
        name = "rotorweb-bundle",
        scripts = {"dist/rotorweb-bundle.min.js"}
    })
end

return {
    {Pandoc = ensureHtmlDeps()},
}
