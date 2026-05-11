local Barracuda, super = Class(EnemyBattler)

function Barracuda:init()
    super.init(self)

    -- Enemy name
    self.name = "Barracuda"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("Barracuda")

    -- Enemy health
    self.max_health = 7000
    -- 1050 is 15% of max hp
    self.health = 7000
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 3
    -- Enemy reward
    self.money = 0

    self.tired_percentage = -1
    self.original_y = self.y
    self.start = true
    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.frames = 0
    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        --"Testing_Bullet",
        "Barracuda/bombs",
        "Barracuda/grow",
        "Barracuda/snake",
        "Barracuda/bombs_n_snakes",
        "Barracuda/grow_n_snakes"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "PICK AN EASIER TRACK!",
        "TRYNA GET TO BLIXER HUH?",
        "I DON'T BITE... [wait:6]MUCH."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT " .. self.attack .. " DF " .. self.defense ..
        "\n* The Easiest of the 4 Bosses\n* Fights a lot with Snakes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Snakes, it had to be snakes.",
        "* Corruption keeps spreading across the Arena",
        "* Holy shit is that Barracuda JSAB",
        "* That isn't a fish...",
        "* Barracuda's harmonizing with the beat",
        "[face:SOUL/annoyed, -5, -8][voice:floweytalk2]* It's always this guy..."
    }
    self.Rage = false
    self.Cautious = false
    self.transformed = false
    self.HW_action = false
    -- Text displayed at the bottom of the screen when the enemy has low health
    -- Register act called "Smile"
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Harmonize")
    self:registerAct("Convince")
    Game:setFlag("Convinced", false)
    Game:setFlag("low", false)
    self.Deletion_Barracuda = false
    self.DodgeSoul_first_turn = false
end

function Barracuda:onTurnStart()
    if self.DodgeSoul_first_turn == true then
        Game.battle.battle_ui.encounter_text:setText(
            "* [color:red]You[color:reset] have learned from the mythical heroes...\n* [color:red]You[color:reset] can now dodge just like [color:#00FFFF]t[color:yellow]h[color:green]e[color:#fca600]m[color:reset]!")
        self.DodgeSoul_first_turn = false
    end

    -- If the act happened last turn, reverts effects
    if self.HW_action == true then
        self.HW_action = false
        self.attack = self.attack + 3
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
    end
    -- If the act happened last turn, reverts effects
    if self.Rage == true then
        self.Rage = false
        self.attack = self.attack - 3
        self.defense = self.defense + 3
        self:statusMessage("damage", 3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
    end
    -- If the act happened last turn, reverts effects
    if self.Cautious == true then
        self.Cautious = false
        self.attack = self.attack + 3
        self.defense = self.defense - 3
        self:statusMessage("damage", -3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
    end

    if Game:getFlag("Convinced", true) then
        self:spare()
        if #Game.battle:getActiveEnemies() == 0 then
            Game.battle.battle_ui.encounter_text:setText("")
            Game.battle:setState("TRANSITIONOUT")
        end
    end

    if Game:getFlag("low", true) then
        Game.battle.battle_ui.encounter_text:setText("")
        Game.battle:setState("TRANSITIONOUT")
    end

    if self.transformed == true then
        Game:setFlag("low", true)
    end
    if self.start == true then
        self.original_y = self.y
        self.start = false
    end

    if self.Deletion_Barracuda == true then
        self.Deletion_Barracuda = false
    end
end

-- function Barracuda:onTurnEnd()
--     if self.health < self.max_health * 0.15 + 1 then
--         self.wave_override = "Barracuda/bombs"
--self.transformed = true
--self:heal(math.huge)
--    end
--end

function Barracuda:getDamageSound()
    return "JSAB_hit"
end

function Barracuda:getTarget()
    -- If Barracuda got hit with deletion in the same round, forces SD to get targetted and also inflicts rage
    if self.Deletion_Barracuda == true then
        self.dialogue_override = "YOU WILL PAY"
        self.Rage = true
        self.attack = self.attack + 3
        self.defense = self.defense - 3
        self:statusMessage("damage", -3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
        Game.battle:target(Game.battle:getPartyBattler("SD"))
        return Game.battle:getPartyBattler("SD")
    else
        return super.getTarget(self)
    end
end

function Barracuda:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if not (amount == 0 or (amount < 0 and Game:getConfig("damageUnderflowFix"))) and not (battler == nil) then -- If damage isn't 0 or below if the config is true does stuff
        if battler.chara:getWeapon("jvab") then                                                                 -- Check if the battler has said weapon and do stuff if so
            amount = amount * 2
        end
    end
    super.hurt(self, amount, battler, on_defeat, color, show_status, attacked) -- Proceed to do the normal stuff
end

function Barracuda:onAct(battler, name)
    -- dynamic check
    if name == "Check" then
        return ("* BARRACUDA - AT " .. self.attack .. " DF " .. self.defense ..
            "\n* The Easiest of the 4 Bosses\n* Fights a lot with Snakes.")
    elseif name == "Harmonize" then
        -- replaces the current act with the next one
        self:registerAct("Disrupt")
        self:removeAct("Harmonize")
        return "* You try to Harmonize with Barracuda...\n[wait:10]* ...Obviously, it didn't work."
    elseif name == "Disrupt" then
        -- replaces the current act with the next one and alters stats
        self.attack = self.attack + 1
        self.defense = self.defense - 1
        self:statusMessage("damage", -1, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 1, { 1, 0.5, 0.5 })
        self:registerAct("Talk")
        self:removeAct("Disrupt")
        return { "* You disrupt Barracuda's Beat.\n[wait:7]* He isn't very happy about that.",
            "* Barracuda's Attack increased! Though he leaves his guard down!" }
    elseif name == "Talk" then
        -- replaces the current act with the next one and alters stats
        self.dialogue_override = "YOU LIE!"
        self.Rage = true
        self.attack = self.attack + 3
        self.defense = self.defense - 3
        self:statusMessage("damage", -3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
        self:registerAct("Think")
        self:removeAct("Talk")
        self.wave_override = "Barracuda/dodgesoul_scripted"
        -- checks, if Shopkeeper Cube was talked to
        if Game:getFlag("Talked_with_cube", false) then
            return { "* You mention how Cube told you about Blixer.\n[wait:10]* That he wouldn't want this anymore.",
                "* Barracuda becomes blinded with rage for this turn! Idiot!",
                "[wait:5]* Talking didn't work...\n* and neither did Harmonizing or Disrupting, what can?" }
        else
            return { "* You mention that Barracuda's Boss\n* wouldn't want this anymore",
                "* Barracuda becomes blinded with rage for this turn! Idiot!",
                "[wait:5]* Talking didn't work...\n* and neither did Harmonizing or Disrupting, what can?" }
        end
    elseif name == "Think" then
        -- replaces the current act with the next one and alters stats
        self.dialogue_override = "..."
        self.Cautious = true
        self.attack = self.attack - 3
        self.defense = self.defense + 3
        self:statusMessage("damage", 3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
        self:registerAct("Convince")
        self:removeAct("Think")
        return { "* You think about what to do,\n* to convince Barracuda of mercy...",
            "* Maybe you have an idea now?",
            "* Barracuda notices this, his defense increases!\n* Though he holds back to do so." }
    elseif name == "Convince" then
        -- alters stats and (TBD) starts final attack
        self.attack = self.attack + 3
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
        self.dialogue_override = "YOU WILL DIE"
        self.wave_override = "Barracuda/Final_Attack"
        Game.battle:startActCutscene("Barracuda", "Convince")
        self:heal(math.huge)
        return
    elseif name == "Standard" then --X-Action
        if battler.chara.id == "susie" then
            -- Wastes Susie's turn
            return "* Susie tried to get Barracuda's attention.\n* Barracuda couldn't hear it just due to beats."
        elseif battler.chara.id == "Fifty" then
            -- Wastes Fifty's turn
            return "* Fifty looked at Barracuda and taunted him.\n* Barracuda didn't hear it thanks to just beats."
        elseif battler.chara.id == "Honeywisp" then
            -- Heals Barracuda, though also weakens him for the turn
            self.HW_action = true
            local base_heal = battler.chara:getStat("magic") + 30
            local heal_amount = Game.battle:applyHealBonuses(base_heal, battler.chara)
            self:heal(heal_amount)
            battler:hurt(math.huge)
            self.attack = self.attack - 3
            self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
            return {
                "* Honeywisp threw Nectar at Barracuda in hopes to calm him down.\n* Barracuda appreciates it!",
                "* Barracuda's Attack decreases for this turn!\n* Use it to your advantage!" }
        elseif battler.chara.id == "SD" then
            -- Wastes SD's turn
            return "* (this is a waste of time...\nUse the main Acts, not this X-act!)"
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " tried to reason with Barracuda.\n* He doesn't listen though..."
        end
    end
    return super.onAct(self, battler, name)
end

function Barracuda:onAdd()
    super.onAdd(self)
end

function Barracuda:update()
    super.update(self)
    -- To be fixed, should bop barracuda up and down (see jevil from deltarune chapter 1)
    if Game:getFlag("Convinced", false) == true or self.transformed == true then
        if not self.original_y == nil then
            self.frames = self.frames + 1
            self.y = self.original_y + (math.sin(self.frames) * 30) -- this makes the enemy sway left and right
        end
    end
end

return Barracuda
