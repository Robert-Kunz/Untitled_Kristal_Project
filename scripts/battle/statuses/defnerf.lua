---@class StatusCondition.atkboost : StatusCondition
local defnerf, super = Class(StatusCondition)

function defnerf:init(amplifier)
    super.init(self)

    self.name = "DefenseDown"

    self.amplifier = amplifier or 2

    self.desc = ("Decreases effective DEF by %s."):format(self.amplifier)

    self.default_turns = 2

    self.icon = "ui/status/defnerf"
end

function defnerf:applyStatModifier(stat, value)
    if stat == "defense" then
        value = value - self.amplifier
    end
    return value
end

return defnerf
