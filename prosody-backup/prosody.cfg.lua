-- Global configuration for Prosody
admins = { "focus@auth.meet.jitsi" }

plugin_paths = { "/prosody-plugins-custom" }

-- Disable SSL since Jitsi uses its own certificates
ssl = {
    key = "/config/certs/localhost.key";
    certificate = "/config/certs/localhost.crt";
}
EOF