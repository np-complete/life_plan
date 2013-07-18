$(document).ready ->
    cleaning = ->
        $(".program").removeClass("info").removeClass("warning").removeClass("success")
    track_toggle = (val) ->
        _gaq.push ['_trackEvent', 'change-programs', "show-#{val}"]

    $("#show-watching").click (e) ->
        cleaning()
        track_toggle 'programs'
        $("#programs").attr("class", "my-programs")

    $("#show-watchable").click (e) ->
        cleaning()
        track_toggle 'channels'
        $("#programs").attr("class", "my-channels")
        $(".watching").addClass("info")

    $("#show-all").click (e) ->
        cleaning()
        track_toggle 'all'
        $("#programs").attr("class", "all-programs")
        $(".program.watchable").addClass("warning")
        $(".program.watching").addClass("info")
        $(".program.watching.watchable").removeClass("info").removeClass("warning").addClass("success")
    reload = ->
        $("#program-controls .active").click()

    $(".toggle-watch").on 'switch-change', (e, data) ->
        value = data.value
        title_id = data.el.attr("title_id")
        method = if value then "PUT" else "DELETE"
        other_inputs = $(".program.title_#{title_id}")
        return false if other_inputs.length > 0 && other_inputs.hasClass("watching") == value
        $.ajax {
            url: "/titles/#{title_id}",
            method: method
            success: (res) ->
                if value
                    $(".program.title_#{title_id}").addClass("watching")
                else
                    $(".program.title_#{title_id}").removeClass("watching")
                $(".toggle-watch.title_#{title_id}").bootstrapSwitch('setState', value)
                reload()
        }

    $("#program-controls #show-watching").click()
