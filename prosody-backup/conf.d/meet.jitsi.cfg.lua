-- Minimal Prosody config for Jitsi with token moderation

-- Tell Prosody where to look for custom modules
-- plugin_paths = { 
--     "/prosody-plugins-custom/mod_token_affiliation", 
--     "/prosody-plugins-custom/mod_token_verification" 
-- }

plugin_paths = { "/prosody-plugins-custom" }

-- Admin user
admins = { "focus@auth.meet.jitsi" }

-- Main virtual host
VirtualHost "meet.jitsi"
    authentication = "token"
    app_id = "eewev03r3-rj"
    app_secret = "ba48cba3ed5c8ac1c2750571cc1588a099c3518dcae25ad1de3193facde926e1"
    allow_empty_token = false

-- MUC (conference) component
Component "conference.meet.jitsi" "muc"
    modules_enabled = {
        "token_verification";
        "token_affiliation"; -- mandatory for moderator control
        "muc_limits";        -- optional
    }
    restrict_room_creation = "local"
    muc_room_cache_size = 1000
