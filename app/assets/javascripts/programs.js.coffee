$(document).ready ->
    cleaning = ->
        $(".program").removeClass("info").removeClass("warning").removeClass("success")
    track_toggle = (val) ->
        ga 'send', 'event', 'program', 'toggle', "show-#{val}"
    $("#show-watching").change (e) ->
        cleaning()
        track_toggle 'programs'
        $("#programs").attr("class", "my-programs")

    $("#show-watchable").change (e) ->
        cleaning()
        track_toggle 'channels'
        $("#programs").attr("class", "my-channels")
        $(".watching").addClass("info")

    $("#show-all").change (e) ->
        cleaning()
        track_toggle 'all'
        $("#programs").attr("class", "all-programs")
        $(".program.watchable").addClass("warning")
        $(".program.watching").addClass("info")
        $(".program.watching.watchable").removeClass("info").removeClass("warning").addClass("success")
    reload = ->
        $("#program-controls .active").click()

    $(".toggle-watch").on 'switchChange.bootstrapSwitch', (e, state) ->
        data = $(e.target)
        title_id = data.attr("title_id")
        method = if state then "PUT" else "DELETE"
        other_inputs = $(".program.title_#{title_id}")
        return false if other_inputs.length > 0 && other_inputs.hasClass("watching") == state
        $.ajax {
            url: "/titles/#{title_id}",
            method: method
            success: (res) ->
                if state
                    $(".program.title_#{title_id}").addClass("watching")
                else
                    $(".program.title_#{title_id}").removeClass("watching")
                $("input[title_id=#{title_id}]").bootstrapSwitch('state', state, true)
                reload()
        }

    $("#program-controls #show-watching").click()
