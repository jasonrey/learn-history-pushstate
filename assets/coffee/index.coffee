$ ->
    # Route library
    $.fn.route = (data) ->
        element = $ @

        history.pushState data, "", element.attr "href"

        document.title = element.attr "title"

    # Fix Chrome's initial pushState issue
    initialUrl = location.href

    buttons = $ ".tabnav a"

    prepareContentFromButton = (button) ->
        tabcontent = $ ".tabcontent .panel-body"

        page = button.data "page"

        buttons.removeClass "active"

        button.addClass "active"

        # Fixes navigation causes hover state to remain on button
        button.trigger "blur"

        $.get "/template/#{page}"
            .done (html) ->
                tabcontent.html html

    # Pop state listener
    $(window).on "popstate", (event) ->

        unless event.originalEvent.state?
            location.href = initialUrl

        data = event.originalEvent.state

        button = buttons.filter "[data-page=#{data.page}]"

        document.title = button.attr "title"

        prepareContentFromButton button

    buttons.on "click", (event) ->
        event.preventDefault()

        button = $ @

        button.route(
            page: button.data "page"
            title: button.attr "title"
        )

        prepareContentFromButton button