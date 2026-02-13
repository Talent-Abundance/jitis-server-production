local jwt = require "luajwt" -- make sure luajwt is installed
local json = require "cjson"

module:hook("muc-occupant-joined", function(event)
    
    local room = event.room
    local occupant = event.occupant

    local token = occupant:get_session():get("token")
    if token then
        local ok, claims = pcall(function()
            return jwt.decode(token, "ba48cba3ed5c8ac1c2750571cc1588a099c3518dcae25ad1de3193facde926e1", true) -- HS256
        end)

        if ok and claims.context and claims.context.user then
            local user = claims.context.user

            -- Set region if it exists
            if user.region then
                occupant:set_property("region", user.region)
                module:log("info", "Occupant %s joined room %s with region=%s", occupant.jid, room.jid, tostring(user.region))
            else
                module:log("warn", "Occupant %s joined room %s but token has no region", occupant.jid, room.jid)
            end

            -- Optional: log affiliation for comparison
            if user.affiliation then
                module:log("info", "Occupant %s affiliation=%s", occupant.jid, tostring(user.affiliation))
            end
        else
            module:log("warn", "Failed to decode token or missing user/context for occupant %s", occupant.jid)
        end
    else
        module:log("warn", "No token found for occupant %s in room %s", occupant.jid, room.jid)
    end
end)
