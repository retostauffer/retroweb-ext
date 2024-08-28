
let $ = require("jquery");

$(document).ready(function() {
    /* If the user uses the quarto Title Block feature the
     * element #title-block-header is a header element. If so,
     * remove. Else do nothing.
     * Rotorweb does this as it will add it's own header for the
     * webheader feature. */
    function remove_title_block_is_header() {
       var tmp = $("#title-block-header");
       var res = false // default
       if ($(tmp).is("header")) {
           res = true; $(tmp).remove()
       }
       return res;
    }

    function webheader_add_content(x, rec) {
        var grd = $("<div class='grid'></div>").appendTo($(x));

        if (rec.icon === null) {
            $("<div class='g-col-12'></div>").appendTo(grd)
        } else {
            $("<div class='g-col-2'>" +
              "  <img class='icon' src='" + rec.icon + "'>" +
              "</div>" +
              "<div class='g-col-10'></div>").appendTo(grd)
        }

        /* Appending title and caption, apply bakcground color (if specified ) */
        if (rec.title) {
            $("<div class='caption-title'></div>")
                    .appendTo($(grd).children("div:last")).html(rec.title);
        }
        if (rec.description) {
            $("<div class='caption-description'></div>")
                    .appendTo($(grd).children("div:last")).html(rec.description);
        }
        if (rec.bg) { $(x).css("background-color", rec.bg) }
    }

    /* Add custom <header> element with id #rotorweb-title-block-header
     * for the webheader feature. For both, type: carousel and type: image.
     * Returns the element added for further processing */
    function add_webheader_header() {
        return $("<header id='rotorweb-title-block-header' class='webheader'></header>").insertAfter("#quarto-header");
    }

    function rotorweb_webheader_carousel() {

        /* See description of corresponding functions for details */
        remove_title_block_is_header()
        var target = add_webheader_header()

        /* Append additional <header> to take up the rotorweb webheader */
        var elemID = "rotorweb-webheader-carousel"

        /* Ensure that we only find it once? */
        var res = "<div id='" + elemID + "' class='carousel slide' data-bs-ride='carousel'>\n"
                + "  <div class='carousel-inner'></div>\n"
                + "</div>"

        // Navigation
        var nav = "<button class='carousel-control-prev' type='button' data-bs-target='#" + elemID + "' data-bs-slide='prev'>"
                + "  <span class='carousel-control-prev-icon' aria-hidden='true'></span>"
                + "</button>"
                + "<button class='carousel-control-next' type='button' data-bs-target='#" + elemID + "' data-bs-slide='next'>"
                + "  <span class='carousel-control-next-icon' aria-hidden='true'></span>"
                + "</button>"

        $(res).appendTo(target)
        $(nav).appendTo("#" + elemID)
        var inner = $("#" + elemID).find(".carousel-inner");
        var ind   = $("<civ class='carousel-indicators'></div>").insertBefore(inner);
        $.each($(rotorweb_webheader_images), function(k, rec) {
            /* adding image (carousel-item) */
            var tmp = $("<div class='carousel-item'>").appendTo(inner);
            var img = $("<img class='d-block w-100' src='" + rec["image"] + "'>").appendTo(tmp)
            if (rec.alt) { $(img).prop("alt", rec.alt); }

            /* Adding title + caption or icon + title + caption (gridded) */
            var cap = $("<div class='carousel-caption d-none d-md-block'>" +
                        "  <div class='container-fluid'></div>" +
                        "</div>").appendTo(tmp)

            /* Appending possibly gridded content */
            webheader_add_content(cap, rec)

            /* adding indicator */
            $("<button type='button' data-bs-target='#" + elemID +
              "' data-bs-slide-to='" + k + "'></button>").appendTo(ind);

        });

        /* Make first image and indicator active */
        $("#" + elemID + " .carousel-item:first").addClass("active")
        $("#" + elemID + " .carousel-indicators button:first").addClass("active")

        var carouselElement = $("#" + elemID);
        var carousel = new bootstrap.Carousel(carouselElement,
                            {interval: rotorweb_webheader_options["interval"]});
    }

    function rotorweb_webheader_image() {

        /* See description of corresponding functions for details */
        remove_title_block_is_header()
        add_webheader_header()

        /* First: create new fluid container to palce the webheader */
        var elemID = "rotorweb-webheader-image";
        var fluid  = $("<div id='" + elemID + "' class='container-fluid webheader'></div>").insertBefore($("#quarto-content"));
        /* If there are multiple images defined: take random one */
        var idx = parseInt(Math.random() * rotorweb_webheader_images.length);
        var rec = rotorweb_webheader_images[idx];

        $("<img class = 'img-contained' src='" + rec.image + "'></img>").appendTo(fluid)
        var cap = $("<div class='carousel-caption d-none d-md-block'></div>").appendTo(fluid)

        /* Appending possibly gridded content */
        webheader_add_content(cap, rec)

    }

    if (typeof rotorweb_webheader_type !== "undefined") {
        if (rotorweb_webheader_type == "carousel") {
            rotorweb_webheader_carousel()
        } else if (rotorweb_webheader_type == "image") {
            rotorweb_webheader_image()
        }
    }
});
