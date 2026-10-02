local clientGameSettings = mjrequire "mainThread/clientGameSettings"

local mod = {
    loadOrder = 1,
}

function mod:onload(world)
    local bridge = nil
    local needsUpdate = false

    local function updateGrassDistance()
        bridge.decalRenderDistance = clientGameSettings.values.grassDistance * 2
    end

    local superSetBridge = world.setBridge
    world.setBridge = function(self, bridge_, serverClientState_, isVR_)
        superSetBridge(self, bridge_, serverClientState_, isVR_)
        bridge = bridge_
        needsUpdate = true
        clientGameSettings:addObserver("grassDistance", updateGrassDistance)
    end

    local superUpdate = world.update
    world.update = function(self, dt)
        superUpdate(self, dt)
        if needsUpdate then
            needsUpdate = false
            updateGrassDistance()
        end
    end
end

return mod
