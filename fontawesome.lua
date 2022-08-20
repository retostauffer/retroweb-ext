

-- Generates fontawesome icons (HTML). Two quarto shortcodes
-- are provided:
-- {{< fa ... >}} Create in-line fontawesome icon.
-- {{< fali ... >}} Fontawesome icons for itemized lists.
--
-- args: define the fontawesome icon. The prefix fa- will be added to each
--       argument used to define the HTML/CSS class.
-- kwargs: named arguments for additional control. Allowed are class=""
--         to add additional classes (e.g., "text-primary" which should not
--         be extended to "fa-text-priamry") and "color" for custom colors.
--
-- Examples:
--    {{< fa brands orcid >}}                            ORCID logo, default color
--    {{< fa brands orcid class="text-primary" >}}       ORCID logo, bootstrap primary color
--    {{< fa brands orcid color="red" >}}                ORCID logo, red
--
-- Itemized lists with fa icons using bootstrap primary and secondary color.
-- Note that the {{< fali ... >}} must not be a the beginning, can also be
-- a the end. Only one icon allowed.
--
-- * {{< fali regular square-check class="text-primary"   >}} First list entry
-- * {{< fali regular square-check class="text-primary"   >}} Second list entry
-- * {{< fali regular square       class="text-secondary" >}} Third list entry
-- * Last entry, no icon.


-- Creates the <i></i> tag; used by both shortcode rules (see below)
local function fa_get_icon(args, kwargs)
    -- parsing kwargs for color and size
    local color = pandoc.utils.stringify(kwargs["color"])
    local style = ""
    if #color ~= 0 then
        style = " style='color: " .. color .. "'"
    end

    -- allow the user to add an additional not fa-* class
    local additionalclass = pandoc.utils.stringify(kwargs["class"])
    local class = nil
    if #additionalclass > 0 then
        class = additionalclass
    end

    -- setting up class (icon definition as well as sizing)
    for i,cls in pairs(args) do
        cls = pandoc.utils.stringify(cls)
        if class == nil then
            class = "fa-" .. cls
        else
            class = class .. " fa-" .. cls
        end
    end

    -- No class set? Render red skull
    if class == nil then
        print("[Rotorweb]: WARNING: {{< fa >}} shortcode missing icon specification!")
        class = "fa-solid fa-skull"
        style = " style='color: red;'"
    end

    return "<i class='" .. class .. "'" .. style .. "></i>"
end

-- shortcode for {{< fa ... >}}, in-line fontawesome icons
function fa(args, kwargs)
    return pandoc.RawInline("html", fa_get_icon(args, kwargs))
end

-- shortcode for {{< fali ... >}} lists with icons
function fali(args, kwargs)
    return pandoc.RawInline("html", "<span class='fa-li'>" .. fa_get_icon(args, kwargs) .. "</span>")
end

