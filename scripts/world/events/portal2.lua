local portal, super = Class(Event)

function portal:init(data)
    super.init(self, data)
    self:setSprite("events/portal/idle", 0.1)
end

function portal:onInteract(player, dir)
    Game.world:startCutscene("Overworld", "portal_to_pik")
    return true
end

return portal
