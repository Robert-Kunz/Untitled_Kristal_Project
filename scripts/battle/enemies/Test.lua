local Test, super = Class(EnemyBattler)

function Test:init()
    super.init(self)

    -- Enemy name
    self.name = "Sushi"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("Test")

    -- Enemy health
    self.max_health = 500
    self.health = 500
    -- Enemy attack (determines bullet damage)
    self.attack = 7
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "fish",
        "test",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Don't say it",
        "It's Fishing time",
        "I am unstealable!",
        "Fish"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 7 DF 2\n* This is just a piece of sushi \n* ...or is it?"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* You feel the power of fish",
        "* Smells fishy in here",
        "* Don't",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The Piece of Sushi is about to burst"

    -- Register act called "Smile"
    self:registerAct("Consume")
    self:registerAct("Take Care")
    self:registerAct("Take Care X", "", { "HW" })
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
end

function Test:onAct(battler, name)
    if name == "Consume" and self.tired then
        self:hurt(math.huge, battler, self.onDefeatFatal)
        battler:heal(math.huge)
        return {
            "* You eat the piece of sushi.",
            "* ...[wait:5][color:blue]Fishy[color:reset]"
        }
    elseif name == "Consume" then
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "GET YOUR GRIMY HANDS OFF ME"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You try to eat the piece of sushi.[wait:5]\n* The piece pushes you away.",
            "* Maybe try to [color:blue]tire[color:reset] it beforehand."
        }
    elseif name == "Take Care X" then
        -- Change this enemy's dialogue for 1 turn
        -- Act text (since it's a list, multiple textboxes)
        self:addMercy(100)
        return {
            "* You and Honeywisp tidy up the piece of sushi.\n* The Piece of Sushi appreciates it"
        }
    elseif name == "Take Care" then
        -- Change this enemy's dialogue for 1 turn
        -- Act text (since it's a list, multiple textboxes)
        self:addMercy(25)
        return {
            "* You tidy up the piece of sushi.\n* The Piece of Sushi appreciates it"
        }
    elseif name == "Standard" and self.tired then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            self:heal(200)
            return "* Ralsei tried patching up the piece.\n* The sushi didn't care."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            self:hurt(math.huge, battler, self.onDefeatFatal)
            return "* Susie ate the piece."
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " straightened the\npiece's fish."
        end
    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei cared for the piece.\n* The sushi didn't care."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            self.dialogue_override = "GET YOUR GRIMY HANDS OFF ME"
            return "* Susie tried to smash the piece.\n* The sushi didn't break."
        elseif battler.chara.id == "SD" then
            -- Change this enemy's dialogue for 1 turn
            -- Act text (since it's a list, multiple textboxes)
            self:addMercy(25)
            return {
                "* SD tidies up the piece of sushi.\n* The Piece of Sushi appreciates it"
            }
        elseif battler.chara.id == "HW" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            local base_heal = battler.chara:getStat("magic") + 30
            local heal_amount = Game.battle:applyHealBonuses(base_heal, battler.chara)
            self:heal(heal_amount)
            battler:hurt(math.huge)
            self:addMercy(75)
            return "* HW healed the Piece of Sushi.\n* The Piece of Sushi appreciates it."
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " straightened the\npiece's fish."
        end
    end
    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Test
