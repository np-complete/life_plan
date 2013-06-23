$(document).ready ->
    $("#show-watching").click (e) ->
        $(".program").hide()
        $(".watching").show()
        $(".program.info").removeClass "info"
        $(".program.warning").removeClass "warning"
    $("#show-watchable").click (e) ->
        $(".program").hide()
        $(".watchable").show()
        $(".watching").show()
        $(".program.warning").removeClass "warning"
        $(".program.watching").addClass "info"
    $("#show-all").click (e) ->
        $(".program").show()
        $(".program.watchable").addClass "warning"
        $(".program.watching").addClass "info"

    $("#program-controls #show-watching").click()
