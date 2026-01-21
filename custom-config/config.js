var config = {
    hosts: {
        domain: 'assessments.v.talent-abundance.com',
        muc: 'conference.assessments.v.talent-abundance.com'
    },
    // Keep all remote tracks even if participants don't send media
    channelLastN: -1,          // send all tracks, never expire
    adaptiveLastN: false,       // disables adaptive LastN
    startWithAudioMuted: false, // optional
    startWithVideoMuted: false, // optional
    enableUserRolesBasedOnToken: true,
    
    // P2P settings
    p2p: {
        enabled: false,         // disable P2P to avoid direct ICE failures
        useStunTurn: true
    },
    
    // ICE/connection robustness
    disableIceRestart: false,
    useStunTurn: true,

    startWithAudioMuted: true,  // optional: avoids permission issues initially
    startWithVideoMuted: true,  // optional: avoids errors if camera denied
    enableNoisyMicDetection: false,  // avoid unnecessary audio track removal
    disableSuspendVideo: true,       // prevent video suspension when idle
    
    // misc
    enableLipSync: true,
    enableRemb: true,
    hiddenDomain: 'recorder.meet.jitsi', // if using recording
    startAudioOnly: false,

    closePage: 'static/close2.html',
};

config.enableClosePage = true;
config.closePageUrl = 'https://talent-abundance.com'