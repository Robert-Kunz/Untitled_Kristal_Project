local MISSINGNO, super = Class(EnemyBattler)

function MISSINGNO:init()
    super.init(self)

    -- Enemy name
    self.name = "MISSINGNO"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("enemymissingno")

    -- Enemy health
    self.max_health = 239493
    self.health = 2394
    -- Enemy attack (determines bullet damage)
    self.attack = 20
    -- Enemy defense (usually 0)
    self.defense = -100
    -- Enemy reward
    self.money = 00110000

    self.tired_percentage = -1
    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "bombs",
        "smashcut",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "!!!!!!",
        "WhY rEsiTs?",
        "01010010 01010101 01001110",
        "01001100 01000101 01000001 01010110 01000101",
        "FaTE dEterMINeD",
        "1T H00RTS",
        "D0n'7 L34V3 M3"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT " + self.attack + " DF " + self.defense +
        "\n* The Easiest of the 4 Bosses\n* Fights a lot with Snakes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Snakes, it had 0b1e2 s235ke.",
        "* The air crackles with... Freedom?",
        "* You feel your very body tear apart...",
        "* MISSINGNO's looking kind of unstable...",
        "* HUND [wait:7]KLAAAAAAVIERRRRRRRRRR",
        "* The [MISSINGO] gives you a [darker yet darker] smile.",
        "* The area keeps changing...",
        "* '[voice:missingno]01001000 01000101 01001100 01010000\n 00100000 01001101 01000101[voice:reset]'\n* It says",
        "* "
    }

    self.siner = 0
    self.intensity = 0
    self.flash_timer = 0
    self.glitched_out = false
end

function MISSINGNO:getDamageSound()
    local rand = Utils.random(0, 15, 1) + 1
    Kristal.Console:log(rand)
    local file_stuff = "voice/missingno/glitch_" .. rand
    Kristal.Console:log(file_stuff)
    local snd = Utils.pick({ file_stuff })
    local pitch = 0.80 + Utils.random(0.2)
    Assets.playSound(snd, 0.7, pitch)
    return true
end

function MISSINGNO:onTurnStart()
    self.glitched_out = false
    self.name = "MISSINGNO"
    self:setAnimation("idle")
    self.random_stuff = math.random(1, 10)
    --self.random_stuff = 1
    if self.random_stuff == 1 then
        self.name = "Barracuda"
        self:setAnimation("Barracuda")
        self.wave_override = "glitch_barracuda"
        self.dialogue_override = "TRYNA GET TO BLIXER HUH?"
    elseif self.random_stuff == 2 then
        self.name = "Sushi"
        self:setAnimation("Sushi")
        self.wave_override = "test"
        self.dialogue_override = "It's Fishing time"
    elseif self.random_stuff == 3 then
        self.name = "Barracuda"
        self:setAnimation("Barracuda")
        self.wave_override = "bombs"
        self.dialogue_override = "TRYNA GET TO BLIXER HUH?"
    elseif self.random_stuff == 4 then
    elseif self.random_stuff == 5 then
    end
    Kristal.Console:log(self.random_stuff)
    super.onTurnStart(self)
end

function MISSINGNO:getEnemyDialogue()
    return super.getEnemyDialogue(self)
end

function MISSINGNO:onTurnEnd()
    super.onTurnEnd(self)
end

function MISSINGNO:getTarget()
    return super.getTarget(self)
end

function MISSINGNO:hurt(amount, battler, on_defeat, color, show_status, attacked)
    self.glitched_out = true
    return super.hurt(self, amount, battler, on_defeat, color, show_status, attacked)
end

function MISSINGNO:draw()
    if self.glitched_out == true then
        self.intensity = 200 -- How far the screen smashes apart
        self.flash_timer = 1
        if self.intensity > 1 and (not self.already_drawn) then
            Kristal.Console:log("haw haw")
            self.already_drawn = true

            -- Move screen side to side
            local offset = math.sin(self.siner * 1.5) * self.intensity
            local height = 480 / 2 - 70

            love.graphics.clear()

            -- Top Half
            love.graphics.push()
            love.graphics.setScissor(0, 0, 640, height)
            love.graphics.translate(offset, 0)
            Game.stage:draw()
            love.graphics.pop()
            --
            -- Bottom Half
            love.graphics.push()
            love.graphics.setScissor(0, height, 640, 480)
            love.graphics.translate(-offset, 0)
            Game.stage:draw()
            love.graphics.pop()

            -- GUI
            love.graphics.push()
            love.graphics.setScissor(0, 325, 640, 480)
            Game.stage:draw()
            love.graphics.pop()

            --Reset Scissors
            love.graphics.setScissor()

            if self.flash_timer > 0 then
                -- Smash CUT
                local bar_height = 30 * self.flash_timer
                love.graphics.setColor(1, 1, 1, self.flash_timer)
                love.graphics.rectangle("fill", 0, height - (bar_height / 2), 640, bar_height)
                love.graphics.setColor(1, 1, 1, 1)
            end
            self.already_drawn = false
        end
    end
    super.draw(self)
end

function MISSINGNO:onAct(battler, name)
    -- dynamic check
    if name == "Check" then
        if self.name == "MISSINGNO" then
            return { ("* MISSINGNO NR. 000 - AT " + self.attack + " DF " + self.defense +
                "\nThe Reality Pokémon"), "TYPE     Bird, Normal\nHT       3'3\nWT       22.0 lbs.",
                "* Not many have seen MISSINGNO and lived to tell the tale.",
                "* It is said that MISSINGNO can alter reality itself, though this remains to be proven..." }
        else
            return { (self.name + "...? - AT " + self.attack + " DF " + self.defense +
                "\nThe Transformed"), ("[wait:7]* ...That isn't the real [color:yellow]" + self.name + "[color:reset]...\n* Is it?") }
        end
    elseif name == "Standard" then --X-Action
        if battler.chara.id == "Honeywisp" then
            -- Heals Barracuda, though also weakens him for the turn
            local base_heal = battler.chara:getStat("magic") + 30
            local heal_amount = Game.battle:applyHealBonuses(base_heal, battler.chara)
            self:heal(heal_amount)
            battler:hurt(math.huge)
            return {
                "* Honeywisp threw Nectar" }
        elseif battler.chara.id == "SD" then
            -- Wastes SD's turn
            return "* (this is a waste of time...\nUse the main Acts, not this X-act!)"
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " couldn't comprehend [color:grey]IT[color:reset]"
        end
    end
    return super.onAct(self, battler, name)
end

function MISSINGNO:update()
    self.siner = self.siner + DT
    if self.flash_timer > 0 then
        self.flash_timer = self.flash_timer - (DT * 2)
    end
    if self.glitched_out == true then
        super.update(self)
    end
    super.update(self)
end

return MISSINGNO
