local json = require "util.json"
local st = require "util.stanza"
local mime = require "mime"

-- Function to decode base64url (JWT payload)
local function base64url_decode(input)
    input = input:gsub("-", "+"):gsub("_", "/")
    local padding = #input % 4
    if padding > 0 then
        input = input .. string.rep("=", 4 - padding)
    end
    return mime.unb64(input)
end

-- Hook for every occupant joining a MUC, HIGH priority
module:hook("muc-occupant-pre-join", function(event)
    local session = event.origin
    local occupant = event.occupant
    local presence = event.stanza

    -- Step 1: extract JWT from URL if session.auth_token is nil
    if not session.auth_token then
        local url_jwt = session.jitsi_web_query and session.jitsi_web_query.jwt
        if url_jwt then
            session.auth_token = url_jwt
            module:log("info", "Injected JWT from URL into session.auth_token")
        end
    end

    -- Step 2: if still missing, warn and skip
    if not session or not session.auth_token then
        module:log("warn", "No auth_token in session for occupant: %s", tostring(occupant.nick))
        return
    end

    -- Step 3: decode JWT
    local header, payload, signature = session.auth_token:match("([^%.]+)%.([^%.]+)%.([^%.]+)")
    if not payload then
        module:log("warn", "Invalid JWT format for occupant: %s", tostring(occupant.nick))
        return
    end

    local decoded = base64url_decode(payload)
    local data = json.decode(decoded)

    -- Step 4: determine region based on affiliation
    local region = "in"  -- default region
    if data and data.context and data.context.user and data.context.user.affiliation then
        local affiliation = data.context.user.affiliation:lower()
        if affiliation == "owner" then
            region = "bh"  -- owner gets Bahrain region
        end
    end

    -- Step 5: log for debugging
    module:log("info", "Assigning region '%s' for occupant %s", region, tostring(occupant.nick))

    -- Step 6: inject region into presence
    presence:add_child(
    st.stanza("jitsi_participant_region", {
        xmlns = "http://jitsi.org/jitmeet"
    }):text(region)
)
end, 100)  -- HIGH priority to run before other modules
