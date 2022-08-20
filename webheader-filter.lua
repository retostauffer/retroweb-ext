
local function webheader(meta)

    -- print("[Rotorweb] Executing header manipulation filter")

    function to_json(key, value)
        if value == nil then
            return key .. ": null"
        else
            return key .. ": '" .. value .. "'"
        end
    end

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
            print("[Rotorweb] WARNING: webheader does not contain any images. Ignore.")
        else
            -- User has chosen to display a carousel header
            if (type == "carousel") or (type == "image") then
                -- Evaluate carousel options
                -- Defaults:
                local interval = 4000;  -- default intreval speed (milliseconds)
                if meta.webheader.options ~= nil and meta.webheader.options.interval ~= nil then
                    interval = pandoc.utils.stringify(meta.webheader.options.interval)
                end

                local res = "<script>\nvar rotorweb_webheader_images = ["
                for k,img in pairs(meta.webheader.images) do
                    -- parsing image with all its tags
                    -- nil (lua's null value) will be converted to JSON 'null' in to_json
                    local image       = nil
                    local alt         = nil
                    local title       = nil
                    local description = nil
                    local icon        = nil
                    local bg          = nil
                    if img.image       ~= nil then image       = pandoc.utils.stringify(img.image);       end
                    if img.alt         ~= nil then alt         = pandoc.utils.stringify(img.alt);         end
                    if img.title       ~= nil then title       = pandoc.utils.stringify(img.title);       end
                    if img.description ~= nil then description = pandoc.utils.stringify(img.description); end
                    if img.icon        ~= nil then icon        = pandoc.utils.stringify(img.icon);        end
                    if img.bg          ~= nil then bg          = pandoc.utils.stringify(img.bg);          end

                    -- image defined?
                    if not image ~= nil then
                        res = res .. "{" .. to_json("image", image) .. ", "
                                         .. to_json("alt", alt) .. ", "
                                         .. to_json("title", title) .. ", "
                                         .. to_json("description", description) .. ", "
                                         .. to_json("icon", icon) .. ", "
                                         .. to_json("bg", bg) .. "}, "
                    end
                end
                res = res .. "];\n"

                res = res .. "var rotorweb_webheader_type = '" .. type .."'\n"
                res = res .. "var rotorweb_webheader_options = {interval: " .. interval .. "}\n"
                res = res .. "</script>\n"

                quarto.doc.includeText("in-header", res)
                quarto.doc.includeFile("in-header", "scripts/webheader.html")

            -- Warning unknown type
            else
                print("[Rotorweb] WARNING: wehbheader type `" .. type .. "` unknown. Ignored.")
            end
        end -- end meta.webheader.images not nil
    end -- end meta.webheader not nil

end



return {{
    Meta = webheader,
}}

