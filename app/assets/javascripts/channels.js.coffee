$(document).ready ->
    $(".channel-toggle").click (e) ->
        channel_id = $(this).attr("channel-id")
        method = if $(this).hasClass("active") then "DELETE" else "PUT"
        _gaq.push ["_trackEvent", "toggle-watch-channel", "#{method} - #{$(this).text()}"]
        $.ajax {
            url: "/channels/#{channel_id}",
            method: method
        }
    $("#channel-group a:first").tab("show")
    $("#channel-group a").click (e) ->
        _gaq.push ["_trackEvent", "show-channels", $(this).text()]
        $(this).tab("show")
        false
