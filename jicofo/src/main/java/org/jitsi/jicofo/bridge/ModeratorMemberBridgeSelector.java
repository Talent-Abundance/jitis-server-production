package org.jitsi.jicofo.bridge;

import org.jitsi.jicofo.bridge.Bridge;
import org.jitsi.jicofo.bridge.BridgeSelector;
import org.jitsi.jicofo.bridge.ParticipantProperties;

import java.util.List;
import java.util.Optional;

public class ModeratorMemberBridgeSelector implements BridgeSelector {

    private final BridgeSelector defaultSelector;

    public ModeratorMemberBridgeSelector(BridgeSelector defaultSelector) {
        this.defaultSelector = defaultSelector;
    }

    @Override
    public Bridge selectBridge(ParticipantProperties participantProperties, List<Bridge> bridges) {
        // Default fallback
        if (bridges == null || bridges.isEmpty()) {
            return null;
        }

        // Check if participant is moderator
        boolean isModerator = participantProperties.isModerator();

        // Assign bridges based on role
        Optional<Bridge> selectedBridge = bridges.stream().filter(b -> {
            if (isModerator) {
                return "bh".equalsIgnoreCase(b.getRegion());
            } else {
                return "in".equalsIgnoreCase(b.getRegion());
            }
        }).findFirst();

        // If not found, fallback to default selection
        return selectedBridge.orElse(defaultSelector.selectBridge(participantProperties, bridges));
    }
}
