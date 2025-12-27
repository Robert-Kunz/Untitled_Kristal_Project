---@class StatusCondition.defnerf : StatusCondition
local defnerf, super = Class(EnemyStatusCondition)

function defnerf:init(amplifier)
    super.init(self)

    self.name = "DefenseDown"

    self.amplifier = amplifier or 2

    self.desc = ("Decreases effective DEF by %s."):format(self.amplifier)

    self.default_turns = 2

    self.icon = "ui/status/defnerf"
end

function defnerf:onStatus(battler)
    battler:statusMessage("damage", -self.amplifier, { 0.5, 0.5, 1 })
    battler.defense = battler.defense - self.amplifier
    return
end

function defnerf:onCure(battler)
    battler:statusMessage("damage", self.amplifier, { 0.5, 0.5, 1 })
    battler.defense = battler.defense + self.amplifier
end

return defnerf
