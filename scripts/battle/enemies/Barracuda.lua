local Barracuda, super = Class(EnemyBattler)

function Barracuda:init()
    super.init(self)

    -- Enemy name
    self.name = "Barracuda"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("Barracuda")

    -- Enemy health
    self.max_health = 7000
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
        "bombs",
        "grow"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "PICK AN EASIER TRACK!",
        "TRYNA GET TO BLIXER HUH?",
        "I DON'T BITE... [wait:6]MUCH."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT " + self.attack + " DF " + self.defense +
        "\n* The Easiest of the 4 Bosses\n* Fights a lot with Snakes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Snakes, it had to be snakes.",
        "* Corruption keeps spreading across the Arena",
        "* Holy shit is that Barracuda JSAB",
        "* That isn't a fish...",
        "* Barracuda's harmonizing with the beat"
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
    Game:setFlag("Convinced", false)
    Game:setFlag("low", false)
end

function Barracuda:onTurnStart()
    if self.HW_action == true then
        self.HW_action = false
        self.attack = self.attack + 3
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
    end
    if self.Rage == true then
        self.Rage = false
        self.attack = self.attack - 3
        self.defense = self.defense + 3
        self:statusMessage("damage", 3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
    end

    if self.Cautious == true then
        self.Cautious = false
        self.attack = self.attack + 3
        self.defense = self.defense - 3
        self:statusMessage("damage", -3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
    end

    if Game:getFlag("Convinced", true) or Game:getFlag("low", true) then
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
end

function Barracuda:onTurnEnd()
    if self.health < self.max_health * 0.15 + 1 then
        Game.battle:startCutscene("Barracuda", "low_health")
        Game.battle:setState("CUTSCENE")
        self.transformed = true
        self:heal(math.huge)
    end
end

function Barracuda:onAct(battler, name)
    if name == "Check" then
        return ("* BARRACUDA - AT " + self.attack + " DF " + self.defense +
            "\n* The Easiest of the 4 Bosses\n* Fights a lot with Snakes.")
    elseif name == "Harmonize" then
        -- Loop through all enemies
        self:registerAct("Disrupt")
        self:removeAct("Harmonize")
        return "* You try to Harmonize with Barracuda...\n[wait:10]* ...Obviously, it didn't work."
    elseif name == "Disrupt" then
        -- Loop through all enemies
        self.attack = self.attack + 1
        self.defense = self.defense - 1
        self:statusMessage("damage", -1, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 1, { 1, 0.5, 0.5 })
        self:registerAct("Talk")
        self:removeAct("Disrupt")
        return { "* You disrupt Barracuda's Beat.\n[wait:7]* He isn't very happy about that.",
            "* Barracuda's Attack increased! Though he leaves his guard down!" }
    elseif name == "Talk" then
        -- Loop through all enemies
        self.dialogue_override = "YOU LIE!"
        self.Rage = true
        self.attack = self.attack + 3
        self.defense = self.defense - 3
        self:statusMessage("damage", -3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
        self:registerAct("Think")
        self:removeAct("Talk")
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
        -- Loop through all enemies
        self.dialogue_override = "..."
        self.Cautious = true
        self.attack = self.attack - 3
        self.defense = self.defense + 3
        self:statusMessage("damage", 3, { 0.5, 0.5, 1 })
        self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
        self:registerAct("Convince")
        self:removeAct("Think")
        return { "* You think about what to do,\n* to convince Barracuda of mercy...",
            "* * Maybe you have an idea now?",
            "* Barracuda notices this, his defense increases!\n* Though he holds back to do so." }
    elseif name == "Convince" then
        -- Loop through all enemies
        self.attack = self.attack + 3
        self:statusMessage("damage", 3, { 1, 0.5, 0.5 })
        self.dialogue_override = ""
        Game.battle:startActCutscene("Barracuda", "Convince")
        Game:setFlag("Convinced", true)
        self:heal(math.huge)
        return
    elseif name == "Standard" then --X-Action
        if battler.chara.id == "susie" then
            -- Wastes Susie's turn
            return "* Susie tried to get Barracuda's attention.\n* Barracuda couldn't hear it just due to beats."
        elseif battler.chara.id == "Fifty" then
            -- Wastes Fifty's turn
            return "* Fifty looked at Barracuda and taunted him.\n* Barracuda didn't hear it thanks to just beats."
        elseif battler.chara.id == "HW" then
            -- Heals Barracuda, though also weakens him for the turn
            self.HW_action = true
            local base_heal = battler.chara:getStat("magic") + 30
            local heal_amount = Game.battle:applyHealBonuses(base_heal, battler.chara)
            self:heal(heal_amount)
            battler:hurt(math.huge)
            self.attack = self.attack - 3
            self:statusMessage("damage", -3, { 1, 0.5, 0.5 })
            return {
                "* Honeywisp threw a Nectar filled Egg at Barracuda in hopes to calm him down.\n* Barracuda appreciates it!",
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
    if Game:getFlag("Convinced", false) == true or self.transformed == true then
        if not self.original_y == nil then
            self.frames = self.frames + 1
            self.y = self.original_y + (math.sin(self.frames) * 30) -- this makes the enemy sway left and right
        end
    end
end

return Barracuda
