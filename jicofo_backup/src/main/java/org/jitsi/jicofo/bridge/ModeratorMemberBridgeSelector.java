package org.jitsi.jicofo.bridge;

import org.jitsi.jicofo.bridge.Bridge;
import org.jitsi.jicofo.bridge.BridgeSelector;
import org.jitsi.jicofo.bridge.ParticipantProperties;
import java.util.List;

public class ModeratorMemberBridgeSelector implements BridgeSelector {

    private final BridgeSelector defaultSelector;

    public ModeratorMemberBridgeSelector(BridgeSelector defaultSelector) {
        this.defaultSelector = defaultSelector;
    }

    @Override
    public Bridge selectBridge(ParticipantProperties participantProperties, List<Bridge> bridges) {
        if (bridges == null || bridges.isEmpty()) {
            return null;
        }

        // Moderator → BH
        if ("owner".equalsIgnoreCase(participantProperties.getAffiliation())) {
            return bridges.stream()
                    .filter(b -> "bh".equals(b.getRegion()))
                    .findFirst()
                    .orElse(defaultSelector.selectBridge(participantProperties, bridges));
        }

        // Non-moderator → IN
        return bridges.stream()
                .filter(b -> "in".equals(b.getRegion()))
                .findFirst()
                .orElse(defaultSelector.selectBridge(participantProperties, bridges));
    }
}
