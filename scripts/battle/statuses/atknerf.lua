---@class StatusCondition.atkboost : StatusCondition
local atknerf, super = Class(StatusCondition)

function atknerf:init(amplifier)
    super.init(self)

    self.name = "AttackDown"

    self.amplifier = amplifier or 2

    self.desc = ("Decreases effective ATK by %s."):format(self.amplifier)

    self.default_turns = 3

    self.icon = "ui/status/atknerf"
end

function atknerf:applyStatModifier(stat, value)
    if stat == "attack" then
        value = value - self.amplifier
    end
    return value
end

return atknerf
