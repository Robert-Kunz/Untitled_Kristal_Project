return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene

    Protect = function(cutscene, battler, enemy)
        local SD = Game.battle:getPartyBattler("SD")
        local HW = Game.battle:getPartyBattler("Honeywisp")
        local dx, dy = SD:getRelativePos(SD.width / 2, SD.height / 2)
        local Hx, Hy = HW:getRelativePos(HW.width / 2, HW.height / 2)
        local heartburst = HeartBurst(dx, dy)
        local soul = Sprite("player/heart_dodge", dx + 5, dy + 5)
        soul:setOrigin(0.5, 0.5)
        Game.battle:addChild(soul)
        Game.battle:addChild(heartburst)
        soul.layer = 1000
        heartburst.layer = 1001
        soul.color = { 1, 0, 0 }
        heartburst.color = { 1, 0, 0 }
        cutscene:wait(2)
        cutscene:wait(cutscene:slideTo(soul, Hx + 100, Hy, 0.5))
        soul:flash()
        cutscene:wait(0.2)
        soul:setColor { 252 / 255, 166 / 255, 0 }
        Assets.playSound("greatshine", 1, 0.8)
        Assets.playSound("greatshine", 1, 1)
        Assets.playSound("closetimpact", 1, 1.5)
        -- Open textbox and wait for completion
        local enemies = Game.battle.enemies
        cutscene:wait(1)
        cutscene:text("* ...", "idle", "Barracuda")
        soul:explode()
    end
}
