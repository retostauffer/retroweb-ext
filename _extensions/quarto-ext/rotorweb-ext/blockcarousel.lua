
function blockcarousel(args, kwargs)

    function random_id(len)
        local res = "carousel-"
        for i = 1, len do res = res .. string.char(math.random(97, 122)); end
        return res
    end

    -- parsing bootstrap 5.0 carousel options
    -- Define defaults:
    local bs_ride     = "carousel"
    local bs_interval = 5000
    local bs_keyboard = "false"
    local bs_pause    = "hover"
    local bs_wrap     = "true"
    local bs_touch    = "true"
    -- Parsing user options (if set)
    for key,val in pairs(kwargs) do
        if key == "interval" then
            bs_interval = pandoc.utils.stringify(val)
        elseif key == "keyboard" then
            if pandoc.utils.stringify(val) == "true" then
                bs_keyboard = "true"
            end
        elseif key == "pause" then
            bs_pause = pandoc.utils.stringify(val)
        elseif key == "ride" then
            bs_ride = pandoc.utils.stringify(val)
        elseif key == "wrap" then
            if pandoc.utils.stringify(val) == "false" then
                bs_wrap = "false"
            end
        elseif key == "touch" then
            if pandoc.utils.stringify(val) == "false" then
                bs_touch = "false"
            end
        end
    end

    -- take custom HTML element ID if specified, else draw a random ID
    local id = pandoc.utils.stringify(kwargs["id"])
    if #id == 0 then id = random_id(6); end

    -- Building bootstrap carousel
    local div_head = "<div id=\"" .. id .. "\" class=\"carousel slide\"" ..
                     " data-bs-ride=\"" .. bs_ride .. "\"" ..
                     " data-bs-interval=\"" .. bs_interval .. "\"" ..
                     " data-bs-keyboard=\"" .. bs_keyboard .. "\"" ..
                     " data-bs-pause=\"" .. bs_pause .. "\"" ..
                     " data-bs-wrap=\"" .. bs_wrap .. "\"" ..
                     " data-bs-touch=\"" .. bs_touch .. "\">" ..
                     "  <div class=\"carousel-inner\">"
    local div_tail = "  </div>" ..
                     "  <button class=\"carousel-control-prev\" type=\"button\" data-bs-target=\"#" .. id .. "\" data-bs-slide=\"prev\">" ..
                     "    <span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>" ..
                     "    <span class=\"visually-hidden\">Previous</span>" ..
                     "  </button>" ..
                     "  <button class=\"carousel-control-next\" type=\"button\" data-bs-target=\"#" .. id .. "\" data-bs-slide=\"next\">" ..
                     "    <span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>" ..
                     "    <span class=\"visually-hidden\">Next</span>" ..
                     "  </button>" ..
                     "</div>"

    local str = ""

    local active = " active"
    for i,img in pairs(args) do
        -- Getting name of the image
        img = pandoc.utils.stringify(img)
        -- If no longer first image, set 'active class' to "" (not active)
        if i > 1 then active = ""; end
        -- Appending the image to the carousel
        str = str .. "<div class=\"carousel-item" .. active .. "\">" ..
                     "  <img src=\"" .. img .. "\" class=\"d-block w-100\">" ..
                     "</div>"
    end

    return pandoc.RawInline("html", div_head .. str .. div_tail)
end
