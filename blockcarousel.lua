
function blockcarousel(args, kwargs)

    function random_id(len)
        local res = "carousel-"
        for i = 1, len do res = res .. string.char(math.random(97, 122)); end
        return res
    end

    local id = pandoc.utils.stringify(kwargs["id"])
    if #id == 0 then id = random_id(6); end

    -- Building bootstrap carousel
    local div_head = "<div id=\"" .. id .. "\" class=\"carousel slide\" data-bs-ride=\"carousel\">" ..
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
