$ ->
    # Route library
    $.fn.route = ->
        element = $ @

        history.pushState {}, "", element.attr "href"

        document.title = element.attr "title"

    buttons = $ ".tabnav a"

    buttons.on "click", (event) ->
        event.preventDefault()

        button = $ @
        tabcontent = $ ".tabcontent .panel-body"

        buttons.removeClass "active"

        button.addClass "active"

        button.route()

        $.get "/template/" + button.data "page"
            .done (html) ->
                tabcontent.html html