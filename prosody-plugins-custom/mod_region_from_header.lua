local st = require "util.stanza"

module:hook("websocket-session", function(event)
    local request = event.request
    local headers = request.headers
    local region = headers["x-proxy-region"]

    if region then
        module:log("info", "WebSocket session region: %s", region)
        event.session.region = region
    end
end)

module:hook("bosh-session", function(event)
    local request = event.request
    local headers = request.headers
    local region = headers["x-proxy-region"]

    if region then
        module:log("info", "BOSH session region: %s", region)
        event.session.region = region
    end
end)

module:hook("muc-occupant-pre-join", function(event)
    local session = event.origin
    local presence = event.stanza

    if session and session.region then
        module:log("info", "Injecting participant region: %s", session.region)

        presence:add_child(
            st.stanza("jitsi_participant_region", {
                xmlns = "http://jitsi.org/jitmeet"
            }):text(session.region)
        )
    end
end, 100)