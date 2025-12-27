---@class StatusCondition.vanished : StatusCondition
local vanished, super = Class(StatusCondition)

function vanished:init()
    super.init(self)

    self.name = "vanished"

    self.desc = ("Makes you invulnerable.")

    self.default_turns = 1

    self.icon = "ui/status/vanished"
end

function vanished:onStatus(battler)
    battler:setAnimation("vanish")
end

function vanished:onHurt(battler)
    battler:statusMessage("damage", 0, { 1, 1, 1 })
    return 0
end

function vanished:onCure(battler)
    battler:setAnimation("returning")
end

return vanished
