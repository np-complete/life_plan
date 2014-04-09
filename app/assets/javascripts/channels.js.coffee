$(document).ready ->
    $(".channel-toggle").click (e) ->
        channel_id = $(this).attr("channel-id")
        method = if $(this).hasClass("active") then "DELETE" else "PUT"
        ga 'send', 'event', 'channel', 'watch', "#{method} - #{$(this).text()}"
        $.ajax {
            url: "/channels/#{channel_id}",
            method: method
        }
    $("#channel-group a:first").tab("show")
    $("#channel-group a").click (e) ->
        ga 'send', 'event', 'channel-group', 'click', $(this).text()
        $(this).tab("show")
        false
