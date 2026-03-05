---@class PartyBattler : Battler
---@field idle_chat_timer number
---@field flattened_act boolean
local PartyBattler, super = HookSystem.hookScript(PartyBattler)

function PartyBattler:init(chara, x, y)
    super.init(self,chara,x,y)
    self.idle_chat_timer = MathUtils.randomInt(10, 30)
    self.flattened_act = false
end

---@return string
function PartyBattler:coloredName()
    return self.chara:coloredName()
end

function PartyBattler:update()
    super.update(self)
    if (Game.battle and StringUtils.contains(Game.battle.state, "SELECT")) then
        self.idle_chat_timer = self.idle_chat_timer - DT
        if (self.idle_chat_timer <= 0) then
            self.idle_chat_timer = 20
            local rand = MathUtils.randomInt(1, 8)
            if (rand == 7) then
                Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self.chara:getBattleChatMessage(Game.battle.encounter:getChatContext(), "IDLE"), MathUtils.randomInt(1, 4))
            end
        end
    else
        self.idle_chat_timer = 20
    end
end

function PartyBattler:down()
    super.down(self)
    local rand = MathUtils.randomInt(1, 4)
    if (rand == 3) then
        Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self.chara:getBattleChatMessage(Game.battle.encounter:getChatContext(), "RAGE"), MathUtils.randomInt(1, 4))
    end
end

function PartyBattler:hurt(amount, exact, color, options)
    super.hurt(self, amount, exact, color, options)
    local rand = MathUtils.randomInt(1, 5)
    if (rand == 4) then
        Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self.chara:getBattleChatMessage(Game.battle.encounter:getChatContext(), "HURT"), MathUtils.randomInt(1, 3))
    end
end

function PartyBattler:revive()
    super.revive(self)
    local rand = MathUtils.randomInt(1, 5)
    if (rand == 4) then
        Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self.chara:getBattleChatMessage(Game.battle.encounter:getChatContext(), "CHEER"), MathUtils.randomInt(1, 4))
    end
end

function PartyBattler:swoon()
    super.swoon(self)
    Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self.chara:getBattleChatMessage(Game.battle.encounter:getChatContext(), "RAGE"), MathUtils.randomInt(1, 3))
end

return PartyBattler