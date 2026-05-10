local Battle, super = HookSystem.hookScript(Battle)

function Battle:onVictory()
    self.current_selecting = 0

    if self.tension_bar then
        self.tension_bar:hide()
    end

    self:endWaves()

    for _, battler in ipairs(self.party) do
        battler:setSleeping(false)
        battler.defending = false
        battler.action = nil

        battler.chara:resetBuffs()

        if battler.chara:getHealth() <= 0 then
            battler:revive()
            battler.chara:setHealth(battler.chara:autoHealAmount())
        end
        if battler.chara == "SD" then
            Kristal.Console:log("Yes i am running the hook")
            battler:setAnimation("battle/act")
        else
            battler:setAnimation("battle/victory")
        end

        local box = self.battle_ui.action_boxes[self:getPartyIndex(battler.chara.id)]
        box:resetHeadIcon()
    end

    self.money = self.money + (math.floor(((Game:getTension() * 2.5) / 10)) * Game.chapter)

    for _, battler in ipairs(self.party) do
        for _, equipment in ipairs(battler.chara:getEquipment()) do
            self.money = math.floor(equipment:applyMoneyBonus(self.money) or self.money)
        end
    end

    self.money = math.floor(self.money)

    self.money = self.encounter:getVictoryMoney(self.money) or self.money
    self.xp = self.encounter:getVictoryXP(self.xp) or self.xp

    -- if (in_dojo) then
    --     self.money = 0
    -- end

    Game.money = Game.money + self.money
    Game.xp = Game.xp + self.xp

    if (Game.money < 0) then
        Game.money = 0
    end

    local win_text = string.format("* You won!\n* Got %s EXP and %s %s.", self.xp, self.money,
        Game:getConfig("darkCurrencyShort"))

    -- if (in_dojo) then
    --     win_text == "* You won the battle!"
    -- end

    if self.used_violence and Game:getConfig("growStronger") then
        local stronger = "You"

        local party_to_lvl_up = {}
        for _, battler in ipairs(self.party) do
            table.insert(party_to_lvl_up, battler.chara)
            if Game:getConfig("growStrongerChara") and battler.chara.id == Game:getConfig("growStrongerChara") then
                stronger = battler.chara:getName()
            end
            for _, id in pairs(battler.chara:getStrongerAbsent()) do
                table.insert(party_to_lvl_up, Game:getPartyMember(id))
            end
        end

        Game.level_up_count = Game.level_up_count + 1
        for _, party in ipairs(TableUtils.removeDuplicates(party_to_lvl_up)) do
            party:onLevelUp(Game.level_up_count)
        end

        win_text = string.format("* You won!\n* Got %s %s.\n* %s became stronger.", self.money,
            Game:getConfig("darkCurrencyShort"), stronger)
        Assets.playSound("dtrans_lw", 0.7, 2)
    end

    win_text = self.encounter:getVictoryText(win_text, self.money, self.xp) or win_text

    if self.encounter.no_end_message then
        self:setState("TRANSITIONOUT")
        self.encounter:onBattleEnd()
    else
        self:battleText(win_text, function()
            self:setState("TRANSITIONOUT")
            self.encounter:onBattleEnd()
            return true
        end)
    end
end

return Battle
