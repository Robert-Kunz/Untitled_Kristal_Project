---@class EnemyStatusCondition.atknerf : StatusCondition
local atknerf, super = Class(EnemyStatusCondition)

function atknerf:init(amplifier)
    super.init(self)

    self.name = "AttackDown"

    self.amplifier = amplifier or 2

    self.desc = ("Decreases effective ATK by %s."):format(self.amplifier)

    self.default_turns = 3

    self.icon = "ui/status/atknerf"
end

function atknerf:onStatus(battler)
    battler.attack = battler.attack - self.amplifier
    battler:statusMessage("damage", -self.amplifier, { 1, 0.5, 0.5 })
    return
end

function atknerf:onCure(battler)
    battler:statusMessage("damage", self.amplifier, { 1, 0.5, 0.5 })
    battler.attack = battler.attack + self.amplifier
end

return atknerf
