$(document).ready ->
    cleaning = ->
        $(".program").removeClass("info").removeClass("warning").removeClass("success")
    $("#show-watching").click (e) ->
        cleaning()
        $("#programs").attr("class", "my-programs")
    $("#show-watchable").click (e) ->
        cleaning()
        $("#programs").attr("class", "my-channels")
        $(".watching").addClass("info")
    $("#show-all").click (e) ->
        cleaning()
        $("#programs").attr("class", "all-programs")
        $(".program.watchable").addClass("warning")
        $(".program.watching").addClass("info")
        $(".program.watching.watchable").removeClass("info").removeClass("warning").addClass("success")
    update_toggle_button = ->
        $(".toggle-watch").text("追加する")
        $(".toggle-watch.active").text("追加済み")
    reload = ->
        update_toggle_button()
        $("#program-controls .active").click()

    update_toggle_button()
    $(".toggle-watch").click (e) ->
        button = $(this)
        title_id = button.attr("title_id")
        method = if button.hasClass("active") then "DELETE" else "PUT"
        $.ajax {
            url: "/titles/#{title_id}",
            method: method
            success: (res) ->
                if method == "DELETE"
                    $(".toggle-watch.title_#{title_id}").removeClass("active")
                    $(".program.title_#{title_id}").removeClass("watching")
                else
                    $(".toggle-watch.title_#{title_id}").addClass("active")
                    $(".program.title_#{title_id}").addClass("watching")
                reload()
        }

    $("#program-controls #show-watching").click()
