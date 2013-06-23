$(document).ready ->
    $("#show-watching").click (e) ->
        $(".program").hide()
        $(".watching").show()
    $("#show-watchable").click (e) ->
        $(".program").hide()
        $(".watchable").show()
    $("#show-all").click (e) ->
        $(".program").show()
    $("#program-controls #show-watching").click()
