


local function webheader(meta)

    print("[Rotorweb]: Executing header manipulation filter")

    -- If we find a carousel definition: add carousel
    -- Note that we are only adding a variable 'header_carousel_images' to
    -- the head of the page; the script included below (includeFile) contains
    -- the jquery code which then builds up the carousel on the page itself.
    if meta.webheader ~= nil then
        local type = "image"
        if meta.webheader.type ~= nil then
            type = pandoc.utils.stringify(meta.webheader.type)
        end -- end parsing type
        if meta.webheader.images == nil then
            print("[Rotorweb]: webheader does not contain any images. Ignore.")
        else
            -- User has chosen to display a carousel header
            if (type == "carousel") or (type == "image") then
                -- Evaluate carousel options
                -- Defaults:
                local interval = 2000;  -- default intreval speed (milliseconds)
                if meta.webheader.options ~= nil and meta.webheader.options.interval ~= nil then
                    interval = pandoc.utils.stringify(meta.webheader.options.interval)
                end

                local res = "<script>\nvar rotorweb_webheader_images = ["
                for k,img in pairs(meta.webheader.images) do
                    local image   = nil
                    local alt     = "NULL" -- javascript NULL value (default)
                    local caption = "NULL" -- javascript NULL value (default)
                    if img.image   ~= nil then image   = pandoc.utils.stringify(img.image);   end
                    if img.alt     ~= nil then alt     = pandoc.utils.stringify(img.alt);     end
                    if img.caption ~= nil then caption = pandoc.utils.stringify(img.caption); end
                    -- image defined?
                    if not image ~= nil then
                        res = res .. "{image: '" .. image .. "', alt: '" .. alt .. "', caption: '" .. caption .. "'}, "
                        quarto.utils.resolvePath(image)
                    end
                end
                res = res .. "];\n"

                res = res .. "var rotorweb_webheader_type = '" .. type .."'\n"
                res = res .. "var rotorweb_webheader_options = {interval: " .. interval .. "}\n"
                res = res .. "</script>\n"

                quarto.doc.includeText("in-header", res)
                quarto.doc.includeFile("in-header", "scripts/webheader.html")
                quarto.utils.dump(tmp)
            -- E    lse if we find a header image: add header image
            elseif type == "image" then
                print("FOUND HEADER IMAGE")
            else
                print("[Rotorweb]: wehbheader type `" .. type .. "` unknown. Ignored.")
            end
        end -- end meta.webheader.images not nil
    end -- end meta.webheader not nil

end



return {{
    Meta = webheader,
}}

