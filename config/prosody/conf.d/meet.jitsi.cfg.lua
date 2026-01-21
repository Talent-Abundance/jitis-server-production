VirtualHost "meet.jitsi"
    authentication = "token"  -- still use token to allow JWT-based join
    app_id = "eewev03r3-rj"   -- required for the JWT plugin to validate
    app_secret = "ba48cba3ed5c8ac1c2750571cc1588a099c3518dcae25ad1de3193facde926e1"
    allow_empty_token = false
    enable_domain_verification = false

    ssl = {
        key = "/config/certs/meet.jitsi.key";
        certificate = "/config/certs/meet.jitsi.crt";
    }

    modules_enabled = {
        "bosh";
        "features_identity";
    }

-- MUC component
Component "muc.meet.jitsi" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_tombstones = false
    muc_room_allow_persistent = false

    modules_enabled = {
        "muc_hide_all";           -- hide rooms from non-members
        "muc_meeting_id";         -- assign meeting IDs to rooms
        "muc_domain_mapper";      -- map domains for MUCs
        "muc_password_whitelist"; -- allow certain JIDs to bypass passwords
        "token_verification";
        "token_affiliation";      -- your custom module for assigning affiliations
    }
