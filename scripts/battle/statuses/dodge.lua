---@class StatusCondition.vanished : StatusCondition
local dodeing, super = Class(StatusCondition)

function dodeing:init()
    super.init(self)

    self.name = "Dodging"

    self.desc = ("1 in 2 chance to avoid damage")

    self.default_turns = 1

    self.icon = "ui/status/dodge"
end

function dodeing:onHurt(battler)
    if math.random(1, 2) == 2 then
        Kristal.Console:log("haw haw")
        battler:statusMessage("damage", 0, { 1, 1, 1 })
        battler:setAnimation("battle/itemready")
        return 0
    end
end

return dodeing
