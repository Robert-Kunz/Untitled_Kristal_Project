return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    low_health = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        Game.battle:setState("CUTSCENE")
        local enemies = Game.battle.enemies
        cutscene:text("* You make a stance infront of Barracuda")
        cutscene:text("* Look, Barracuda, whatever you're trying to do\n* it won't work", "Annoyed", "SD")
        cutscene:text("* We both know how this will end...", "Tired", "SD")
        cutscene:text("* So why don't you just stop?", "Annoyed", "SD")
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:text("* YOU TELL LIES, KID", "angry", "Barracuda")
        cutscene:text("* Listen here...", "Annoyed", "SD")
        cutscene:text("* NO, YOU LISTEN TO ME", "angry", "Barracuda")
        cutscene:text("* THIS AIN'T A RAP BATTLE, KID.\n* AND IT ISN'T THERAPY AS WELL.", "idle", "Barracuda")
        cutscene:text("* I WILL NOT DISAPPOINT BOSS AGAIN.", "angry", "Barracuda")
        cutscene:text("* SO YOU TAKE YOUR EXCUSES...", "angry", "Barracuda")
        for _, v in pairs(enemies) do -- this is a for loop
            if v.id == "Barracuda" then
                -- makes the game wait for the animation to finish
                cutscene:wait(cutscene:setAnimation(v, { "awakening", 0.1, false }))
                v:setAnimation("awakened")
            end
        end
        cutscene:text("* AND LEAVE!", "awakened", "Barracuda")
    end,
    Convince = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* You make a stance infront of Barracuda")
        cutscene:text("* Look, Barracuda, whatever you're trying to do\n* it won't work", "idle", "SD")
        cutscene:text("* We both know how this will end...", "Tired", "SD")
        cutscene:text("* So why don't you just stop?", "idle", "SD")
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:text("* YOU TELL LIES, KID", "angry", "Barracuda")
        cutscene:text("* Listen here...", "Annoyed", "SD")
        cutscene:text("* NO, YOU LISTEN TO ME", "angry", "Barracuda")
        cutscene:text("* THIS AIN'T A RAP BATTLE, KID.\n* AND IT ISN'T THERAPY AS WELL", "idle", "Barracuda")
        cutscene:text("* I WILL NOT DISAPPOINT BOSS AGAIN.", "angry", "Barracuda")
        cutscene:text("* SO YOU TAKE YOUR EXCUSES...", "angry", "Barracuda")
        cutscene:wait(cutscene:setAnimation(enemy, { "awakening", 0.1, false }))
        enemy:setAnimation("awakened")
        --cutscene:wait(3.5)
        cutscene:text("* AND LEAVE!", "awakened", "Barracuda")
        Game:setFlag("Convinced", true)
    end,

    Deletion = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local enemies = Game.battle.enemies
        cutscene:wait(1)
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:text("* YOU,[wait:1] DARE?!", "angry", "Barracuda")
        cutscene:text("* YOU WILL DIE!", "angry", "Barracuda")
        cutscene:text("* Well shit\n* [face:Tired](Didn't expect him to block that, fuck!)", "idle", "SD")
        for _, v in pairs(enemies) do -- this is a for loop
            if v.id == "Barracuda" then
                enemy.Deletion_Barracuda = true
                enemy:setAnimation("idle")
            end
        end
    end,

    power = function(cutscene)
        Game.battle.music:pause()

        -- get vessel position
        local vessel = Game.battle:getPartyBattler("SD")
        local x, y = vessel.x + 14, vessel.y - 30
        local soul = Sprite("player/heart_dodge", x, y)
        -- get Barracuda's position
        local bar = Sprite("bullets/bar", x + 350, y - 50)
        cutscene:wait(1)
        Game.fader:fadeOut(nil, { speed = 0.4 })
        Assets.playSound("screenshake")


        -- Assets.playSound("greatshine")
        cutscene:wait(1)
        bar.layer = 1000
        Game.stage:addChild(bar)
        local bimer = Timer()
        bar:addChild(bimer)
        bimer:every(1 / 15, function()
            -- Cancel timer if the bullet is removed
            if bar:isRemoved() then
                return false
            end

            -- Spawn a new afterimage with 0.4 starting alpha
            local after_image = AfterImage(bar, 0.4)
            bar:addChild(after_image)
        end)
        bar:slideTo(x + 50, y - 50, 1.5, "out-sine")
        cutscene:wait(2)
        soul:setOrigin(0.5, 0.5)
        soul.layer = 1000
        soul:setColor(1, 0, 0)

        Game.stage:addChild(soul)

        Assets.playSound("noise")
        soul:addChild(FlashFade("player/heart_dodge", 0, 0))
        cutscene:wait(2)

        cutscene:wait(0.7)
        Assets.playSound("snd_eye_telegraph")
        cutscene:wait(0.3)

        -- second shine (turn orange)
        local timer = Timer()
        soul:addChild(FlashFade("player/heart_dodge", 0, 0))
        soul:addChild(timer)

        for i = 1, 3 do
            timer:after((i - 1) * 0.08, function()
                local pulse = Sprite("player/heart_dodge", soul.width / 2, soul.height / 2)
                pulse:setOrigin(0.5, 0.5)
                pulse:setColor(252 / 255, 166 / 255, 0)
                pulse.alpha = 0.8
                pulse:setScale(1)

                soul:addChild(pulse)

                timer:tween(0.3, pulse, {
                    scale_x = 3,
                    scale_y = 3,
                    alpha = 0
                }, "linear", function()
                    pulse:remove()
                end)
            end)
        end

        Assets.playSound("greatshine", 1, 0.8)
        -- Assets.playSound("snd_closet_impact", 1, 1.5)

        soul:setColor(252 / 255, 166 / 255, 0)
        soul:addChild(FlashFade("player/heart_dodge", 0, 0))

        local g = Timer()
        soul:addChild(g)
        local text = Text("Press [bind:confirm]", soul.x - 132, 30)
        g:after(1, function()
            text.alpha = 0
            text:setScale(0.5)
            soul:addChild(text)
            g:tween(0.25, text, { alpha = 0.5 }, "out-sine")
        end)

        cutscene:wait(function()
            if Input.pressed("confirm") then
                -- Assets.playSound("snd_eye_telegraph")
                Assets.playSound("bomb")
                soul:removeChild(text)
                g:remove()
                return true
            end
        end)
        -- if your planning something different, get rid of all of this code.
        -- set up dash movement variables (from OrangeSoul)
        local dash_distance = 80
        local dash_time = 10
        local dash_dx = 0
        local dash_dy = 1 -- down
        local act_timer = 0
        local flash_timer = 0
        local trails = {}
        local DTMULT = 1 -- can adjust if your cutscene has delta time scaling

        -- movement loop
        local timer = Timer()
        soul:addChild(timer)

        timer:every(0.016, function()
            -- compute step like OrangeSoul
            local step = (dash_distance / dash_time) * DTMULT
            soul.x = soul.x + dash_dy * step

            -- flash effect (white/orange)
            flash_timer = flash_timer + 1
            if flash_timer % 2 == 0 then
                soul:setColor(1, 1, 1)
            else
                soul:setColor({ 252 / 255, 166 / 255, 0 })
            end

            -- spawn AfterImage trail
            local trail = AfterImage(soul)
            trail.alpha = 0.6
            trail.layer = soul.layer - 1
            Game.battle:addChild(trail)
            table.insert(trails, trail)

            act_timer = act_timer + DTMULT
            if act_timer >= dash_time then
                timer:remove()
                soul:setColor({ 252 / 255, 166 / 255, 0 })
            end

            -- fade and remove trails
            for i = #trails, 1, -1 do
                local t = trails[i]
                t.alpha = t.alpha - 0.08
                if t.alpha <= 0 then
                    t:remove()
                    table.remove(trails, i)
                end
            end
        end)
        bar:slideTo(-50, y - 50, 1.5, "in-cubic")
        cutscene:wait(0.7)

        local g = Timer()
        soul:addChild(g)
        local text = Text("Press [bind:confirm]", soul.x - 132, 30)
        g:after(1, function()
            text.alpha = 0
            text:setScale(0.5)
            soul:addChild(text)
            g:tween(0.25, text, { alpha = 0.5 }, "out-sine")
        end)

        cutscene:wait(function()
            if Input.pressed("confirm") then
                soul:removeChild(text)
                g:remove()
                -- Assets.playSound("snd_eye_telegraph")
                Assets.playSound("bomb")
                return true
            end
        end)



        -- set up dash movement variables (from OrangeSoul)
        local dash_distance = -80
        local dash_time = 10
        local dash_dx = 0
        local dash_dy = 1 -- down
        local act_timer = 0
        local flash_timer = 0
        local trails = {}
        local DTMULT = 1

        -- movement loop
        local timer = Timer()
        soul:addChild(timer)

        timer:every(0.016, function()
            -- compute step like OrangeSoul
            local step = (dash_distance / dash_time) * DTMULT
            soul.x = soul.x + dash_dy * step

            -- flash effect (white/orange)
            flash_timer = flash_timer + 1
            if flash_timer % 2 == 0 then
                soul:setColor(1, 1, 1)
            else
                soul:setColor({ 252 / 255, 166 / 255, 0 })
            end

            -- spawn AfterImage trail
            local trail = AfterImage(soul)
            trail.alpha = 0.6
            Game.stage:addChild(trail)
            trail.layer = 1000
            table.insert(trails, trail)

            act_timer = act_timer + DTMULT
            if act_timer >= dash_time then
                timer:remove()
                soul:setColor({ 252 / 255, 166 / 255, 0 })
            end
            for i = #trails, 1, -1 do
                local t = trails[i]
                t.alpha = t.alpha - 0.08
                if t.alpha <= 0 then
                    t:remove()
                    table.remove(trails, i)
                end
            end
        end)
        cutscene:wait(0.7)
        soul:remove()
        bar:remove()
        Game.fader:fadeIn(nil, { speed = 0.4 })
        Game.battle.music:resume()
        -- Game.battle.music:play("knight")
        Game:setFlag("DashSoul", true)
    end
}
