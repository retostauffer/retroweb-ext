

-- Include js/rotorweb-bundle.js for additional
-- jQuery support plus custom functions for the
-- rotorweb theme.
local function ensureHtmlDeps()
    print(" ------------ reto rotor lua filter ----------------- ")

    -- OS detection
    -- Credits to Zbizu on github.com
    -- Source: https://gist.github.com/Zbizu/43df621b3cd0dc460a76f7fe5aa87f30
    function getOS()
        -- ask LuaJIT first
        if jit then
            return jit.os
        end

        -- Unix, Linux variants
        local fh,err = assert(io.popen("uname -o 2>/dev/null","r"))
        if fh then
            osname = fh:read()
        end
        return osname or "Windows"
    end


    local fonts = {}

    -- Looping trough files
    -- Credits to Zbizu on github.com
    -- Source: https://gist.github.com/Zbizu/346ad78bdc501f003fb262d372afb035
    if getOS():lower() == "windows" then
    	for path in io.popen("cd \"dist\" && dir *.woff2 /b/s"):lines() do
    		print(path) -- path = file name/directory
    	end
    else
        print(" Looking for fonts")
        print(debug.getinfo(1).source)
        print(debug.getinfo(1).short_src)
    	--for path in io.popen("cd _extensions/rotorweb/dist && find . -type f | grep .woff2"):lines() do
    	for path in io.popen("cd _extensions/rotorweb && find dist -type f | grep -E '(ttf|woff2)$'"):lines() do
            print(path)
            print(not(path == nil))
            if not(path == nil) then
    		    print("Adding font file " .. path)
                table.insert(fonts, path)
            else
                print("path is nil?")
            end
    	end
    end
    local count = 0
    for i,f in pairs(fonts) do
        count = count + 1
        print(" - " .. i .. " " .. f)
    end
    print(" - Number of fonts in table: " .. count)

    print(" ------------ reto rotor lua filter ----------------- ")

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
