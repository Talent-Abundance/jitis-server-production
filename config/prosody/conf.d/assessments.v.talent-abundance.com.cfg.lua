VirtualHost "assessments.v.talent-abundance.com"
    authentication = "token"

    app_id = "eewev03r3-rj"
    app_secret = "ba48cba3ed5c8ac1c2750571cc1588a099c3518dcae25ad1de3193facde926e1"
    allow_empty_token = false

    modules_enabled = {
        "bosh";
        "websocket";
        -- "smacks";
        -- "turncredentials";
        "token_affiliation";
    }

    ssl = {
        key = "/config/prosody/certs/assessments.v.talent-abundance.com.key";
        certificate = "/config/prosody/certs/assessments.v.talent-abundance.com.crt";
    }
