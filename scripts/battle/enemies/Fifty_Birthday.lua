local Fifty, super = Class(EnemyBattler)
-- Only here for archiving the original code, differences were moved to the main Fifty enemy
function Fifty:init()
    super.init(self)

    -- Enemy name
    self.name = "Fifty"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("FiftyN")

    -- Enemy health
    self.max_health = 4500
    self.health = 4500
    -- Enemy attack (determines bullet damage)
    self.attack = 13
    -- Enemy defense (usually 0)
    self.defense = 1
    -- Enemy reward
    self.money = 2009

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "spores",
        "bombs",
        "Fgrow",
        "Mixed_barracuda",
        "Sporesbutgood"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "You're the parody, sd!",
        "Dodge, Delete!",
        "I picked up some tricks from that Triangle!",
        "Mushrooms...",
        "HUND KLAVIER!",
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = { "AT 10 DF 2\n* Stupid Birthday crasher...",
        "Shows signs of being able to dodge\n* Maybe you can [color:yellow]distract[color:reset] him?" }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* You feel the power of fish... wait wrong encounter",
        "* Spores cover the area completely",
        "* This isn't dnd...",
        "* (Why did it have to be him?)",
        "* HUND [wait:7]KLAAAAAAVIERRRRRRRRRR",
        "* The air fills with the scent of candles"
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Fifty seems worn out... \n* Now's your chance! Attack while he can't dodge!"
    self.Tirecounter = 0
    self.distracted = false
    self:registerAct("Kill")
    self:registerAct("distract")
    self:registerAct("Dodge Status")
    self:registerAct("Tire")
end

function Fifty:hurt(amount, battler, on_defeat, color, show_status, attacked)
    -- Gives a random chance for Fifty to dodge the attack, so long he isn't distracted or tired
    if math.random(1, 2) == 2 and not (self.distracted == true or self.tired) then
        amount = 0
    end
    return super.hurt(self, amount, battler, on_defeat, color, show_status, attacked)
end

function Fifty:onTurnStart()
    self.distracted = false
end

function Fifty:onDodge(battler, attacked)
    if battler == nil then

    else
        battler:hurt(25)
    end
    super.onDodge(self, battler, attacked)
end

function Fifty:onAct(battler, name)
    if name == "Check" then
        self.dialogue_override = {
            "Really? Checking me?",
            "You really did get rusty, sd.",
            "Must be your Age."
        }
    end

    if name == "Kill" and self.tired then
        self.dialogue_override = {
            "Even when I'm tired...",
            "I'm not letting myself die...",
            "Not like that."
        }
        return {
            "* You slice fifty to pieces...",
            "* ...[wait:5]or you would have, hadn't he put up a decoy"
        }
    elseif name == "Kill" then
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = {
            "Going to such tactics, huh?",
            "You really are a fraud."
        }
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You try slice Fifty to pieces.[wait:5]\n* Fifty dodges easily.",
            "* Maybe try to [color:blue]tire[color:reset] him beforehand."
        }
    elseif name == "distract" and self.tired then
        return "* What are you doing??\n* He already can't dodge!"
    elseif name == "distract" then
        --self.dialogue_override = {
        --    "Haha...",
        --   "Oh that's a funny story!",
        --    "It's surprising",
        --    "you're not funny usually."
        --}
        self.distracted = true
        Game.battle:startActCutscene("Fifty", "Parody")
        return
        --return {
        --    "* You tell Fifty that he's the parody, not you.",
        --    "* Fifty starts laughing, leaving his guard down!",
        --    "* Attack while he isn't dodging!"
        --}
    elseif name == "Tire" and self.tired then
        return "* What are you doing??\n* He's already Tired!"
    elseif name == "Tire" and self.Tirecounter == 3 then
        self:setTired(true)
        return { "* You do something that i haven't defined yet(sorry!)",
            "* Fifty becomes [color:blue]Tired[color:reset]!\n* He's unable to dodge!", }
    elseif name == "Tire" then
        if self.Tirecounter < 3 then
            self.Tirecounter = self.Tirecounter + 1
        end
        return { "* You do something that i haven't defined yet(sorry!)",
            "* Fifty gets more [color:blue]Tired[color:reset]!" }
    elseif name == "Dodge Status" and self.tired then
        return "* Too [color:blue]tired[color:reset] to dodge!\n* Attack now!"
    elseif name == "Dodge Status" then
        return "* Able to dodge\n* Could he stop dodging permanently though?"
    elseif name == "Standard" and self.tired then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            self:heal(200)
            return "* Ralsei tried healing Fifty.\n* Fifty didn't care."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Susie tried to smash Fifty to mush.\n* Fifty pretended it didn't hurt."
        elseif battler.chara.id == "Fifty" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Fifty looked at himself.\n* The Enemy Fifty barely budged."
        elseif battler.chara.id == "SD" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            if Game:getFlag("Profanity", true) == true then
                Game.battle:startActCutscene("Fifty", "Tired")
            elseif Game:getFlag("Profanity", true) == false then
                Game.battle:startActCutscene("Fifty", "Fish_Tired")
            end
            return
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " tried to clean the spores from the air."
        end
    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei cared for Fifty.\n* Fifty didn't care."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            self.dialogue_override = "GET YOUR GRIMY HANDS OFF ME"
            return "* Susie tried to smash Fifty to mush.\n* Fifty didn't even budge."
        elseif battler.chara.id == "Fifty" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            self.dialogue_override = {
                "how... curious...",
                "A clone of me...",
                "right infront of me."
            }

            return "* Fifty looked at himself.\n* The Enemy Fifty copied Fifty's moves."
        elseif battler.chara.id == "SD" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/Fifty.lua)
            if Game:getFlag("Profanity", true) == true then
                Game.battle:startActCutscene("Fifty", "Greatest_Battle")
            elseif Game:getFlag("Profanity", true) == false then
                Game.battle:startActCutscene("Fifty", "Fish_Battle")
            end
            return
        elseif battler.chara.id == "Honeywisp" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/Fifty.lua)
            Game.battle:startActCutscene("Fifty", "Honeywisp")
            return
        else
            -- Text for any other character (like Noelle)
            return "* " .. battler.chara:getName() .. " tried to clean the spores from the air."
        end
    end
    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Fifty
