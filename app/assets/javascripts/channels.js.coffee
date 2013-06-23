$(document).ready ->
    $(".channel-toggle").click (e) ->
        channel_id = $(this).attr("channel-id")
        method = if $(this).hasClass("active") then "DELETE" else "PUT"
        $.ajax {
            url: "/channels/#{channel_id}",
            method: method
        }
    $("#channel-group a:first").tab("show")
    $("#channel-group a").click (e) ->
        $(this).tab("show")
        false
