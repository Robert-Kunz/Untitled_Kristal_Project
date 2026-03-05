EverParty = {}

function EverParty:init()
    local problems = self:diagnose()

    if #problems == 0 then
        print("[EverParty] : EverParty active, all aboard!")
    else
        print("[EverParty] : EverParty active, but the following problems were detected:")
        for _, problem in ipairs(problems) do
            print(problem)
        end
        print("[EverParty] : You may want to address these! Do not report issues that arise from these warnings without seeing if they also arise without.")
    end

    if (Mod and Mod.info and StringUtils.contains(Mod.info.id, "dark_place")) then
        print("[EverParty] : Hey there, Dark Place Legacy!")
    elseif (Mod and Mod.info and StringUtils.contains(Mod.info.id, "dpr")) then
        print("[EverParty] : Howdy, Dark Place Rebirth!")
    elseif (Mod and Mod.info and StringUtils.contains(Mod.info.id, "mimicrune")) then
        print("[EverParty] : Good morning, Mimicrune!")
    end

    self.overworld_row = 0
    self.battle_row = 0
    self.prev_party_size = 0
end

function EverParty:diagnose()
    local problems = {}
    local prefix = "[EverParty] : "
    if Mod.libs["moreparty"] then
        table.insert(problems, prefix.."[[WARNING]] MoreParty detected. EverParty may not function as intended, nor may other libraries, due to invasive overwrites made by that library.")
        table.insert(problems, prefix.."It is reccomended to remove them before you proceed.")
    end
    if Mod.libs["engine-fixes"] then
        table.insert(problems, prefix.."[[WARNING]] Engine Fixes library detected. This will almost certainly break things on modern Kristal (though EverParty should still function hopefully), proceed at your own risk!")
    end
    if Mod.libs["magical-glass"] then
        table.insert(problems, prefix.."[[WARNING : SERIOUS]] Magical Glass detected. There's almost no way this will function as intended, so be warned!")
        table.insert(problems, prefix.."Magical Glass compatibility (among other UI libs) will be added in the future. When it is, this error message will be removed.")
    end
    return problems
end

function EverParty:getConfig(name)
    return Kristal.getLibConfig("everparty", name)
end

---@return number row_size
function EverParty:getRowCheckSize()
    if Game.battle and Game.battle.party then
        -- theoretically this works with 8/12/16 characters. in practice it looks really bad, so lets just not
        if self:getConfig("2x_mode") and #Game.battle.party == 4 then
            return 2
        end
    end
    return self:styleRowMax()
end

---@return number scale
function EverParty:getActionBoxScale(row)
    if Game.battle and Game.battle.party then
        if self:getConfig("2x_mode") and #Game.battle.party == 4 then
            return 0
        end
        if (#Game.battle.party <= 3) or self:styleRowMax() <= 3 then
            return 0
        end
        if (row and math.floor(#Game.battle.party / self:styleRowMax()) <= row) then
            local highest_index = (#Game.battle.party - 1) % self:styleRowMax()
            if (highest_index <= 2) then
                return 0
            end
        end
        return MathUtils.clamp((self:styleRowMax()-1) / (self:styleRowMax()), 0, 1)
    end
    return 0
end

---@return boolean
function EverParty:shouldHalfRaise(checker, selected_row, row, current_selecting, index)
    local row_size = checker
    local is_full_row = math.floor(#Game.battle.party / row_size) > row
    local is_solo_row = false --(#Game.battle.party % row_size) == 1
    local should = false
    should = should or ((current_selecting < index) and (current_selecting % checker == index % checker) and (current_selecting ~= index) and selected_row ~= row)
    if (is_full_row) then return should end
    local index_in_row = ((index-1) % row_size)
    local selected_index_in_row = ((current_selecting-1) % row_size)
    local index_diff = index_in_row - selected_index_in_row
    --if (selected_row ~= row) then Kristal.Console:log(tostring(index_diff)) end
    
    should = should or ((selected_row ~= row) and (current_selecting < index) and not ((index_diff > 0) or (index_diff < -1)))
    return should
end

function EverParty:onKeyPressed(key)
    if not (Game.world and Game.world.healthbar) then
        if (Game.battle) then
            -- only for roulette mode
            if (EverParty:getConfig("ui_style") == "ROULETTE") then
                local battle_rows = math.ceil(#Game.battle.party / self:getRowCheckSize())
                if ((battle_rows < 2) or Battle.state == "ACTIONSELECT") then
                    return
                end
                if key == Input.mod_keybinds["overworld_next_keybind"] then
                    Assets.stopAndPlaySound("wing")
                    self.battle_row = MathUtils.wrap(self.battle_row + 1, 0, battle_rows)
                    Game.battle.battle_ui:updateRow()
                elseif key == Input.mod_keybinds["overworld_previous_keybind"] then
                    Assets.stopAndPlaySound("wing")
                    self.battle_row = MathUtils.wrap(self.battle_row - 1, 0, battle_rows)
                    Game.battle.battle_ui:updateRow()
                end
                return
            end
        end
    end
    local overworld_rows = math.ceil(#Game.party / 3)
    if (overworld_rows < 2) then
        return
    end
    if key == Input.mod_keybinds["overworld_next_keybind"] then
        Assets.stopAndPlaySound("wing")
        self.overworld_row = MathUtils.wrap(self.overworld_row + 1, 0, overworld_rows)
        Game.world.healthbar:updateRow()
    elseif key == Input.mod_keybinds["overworld_previous_keybind"] then
        Assets.stopAndPlaySound("wing")
        self.overworld_row = MathUtils.wrap(self.overworld_row - 1, 0, overworld_rows)
        Game.world.healthbar:updateRow()
    end
end

---@return boolean
function EverParty:isWideStyle()
    local style = self:getConfig("ui_style")
    return style == "CLASSIC" or style == "ROULETTE" or style == "STANDARD"
end

function EverParty:styleRowMax()
    local style = self:getConfig("ui_style")
    return style == "CLASSIC" and 4 or (style == "ROULETTE" or style == "STANDARD") and 3 or style == "BATTLECARD" and 99
end

---@param member PartyMember
function EverParty:registerDefaultChatMessages(member)
    member.default_chat_initialized = true

    -- this is gonna be a nightmare of a function
    local name = member.name

    local messages = {}
    if (name == "Kris") then
        messages["GENERIC/INTRO/1"] = "..."
        messages["GENERIC/INTRO/2"] = "..."
        messages["GENERIC/INTRO/3"] = "..."
        
        messages["GENERIC/IDLE/1"] = "..."
        messages["GENERIC/IDLE/2"] = "..."
        messages["GENERIC/IDLE/3"] = "..."

        messages["GENERIC/HURT/1"] = "..."
        messages["GENERIC/HURT/2"] = "..."

        messages["GENERIC/TAUNT/1"] = "..."
        messages["GENERIC/TAUNT/2"] = "..."
        messages["GENERIC/TAUNT/3"] = "..."
        messages["GENERIC/TAUNT/4"] = "..."

        messages["GENERIC/CHEER/1"] = "..."
        messages["GENERIC/CHEER/2"] = "..."
        messages["GENERIC/CHEER/3"] = "..."

        messages["GENERIC/RAGE/1"] = "..."
        messages["GENERIC/RAGE/2"] = "..."
        messages["GENERIC/RAGE/3"] = "..."

        messages["GENERIC/WORRY/1"] = "[shake:1]..."
        messages["GENERIC/WORRY/2"] = "[shake:1]..."

    elseif (name == "Susie" or name == "Blusie") then
        if (name ~= "Blusie") then
            messages["GENERIC/INTRO/1"] = "LET'S GOOOOOO"
            messages["GENERIC/INTRO/2"] = "This is gonna be easy."
            messages["GENERIC/INTRO/3"] = "Let's do this!"
        else
            messages["GENERIC/INTRO/1"] = "I'm blue!"
        end
        
        messages["GENERIC/IDLE/1"] = "So. Uh. This is taking a while."
        messages["GENERIC/IDLE/2"] = "Can you pick something already??"
        messages["GENERIC/IDLE/3"] = "Bruh oh my gooood"

        messages["GENERIC/HURT/1"] = "YOU DIDN'T SEE THAT. I DODGED."
        messages["GENERIC/HURT/2"] = "Ow fuck"

        messages["GENERIC/TAUNT/1"] = "Eat shit, losers"
        messages["GENERIC/TAUNT/2"] = "Heh. Nice try."
        messages["GENERIC/TAUNT/3"] = "Not even close."
        messages["GENERIC/TAUNT/4"] = "Hah! You wish."

        messages["GENERIC/CHEER/1"] = "Let's go!"
        messages["GENERIC/CHEER/2"] = "It's just too easy."
        messages["GENERIC/CHEER/3"] = "Nice."

        messages["GENERIC/RAGE/1"] = "Oh come on!"
        messages["GENERIC/RAGE/2"] = "That's bullshit."
        messages["GENERIC/RAGE/3"] = "I was going easy on you!"

        messages["GENERIC/WORRY/1"] = "[shake:1]guys, get up"
        messages["GENERIC/WORRY/2"] = "[shake:1]Heh... guess it's just you and me, huh?"
    elseif (name == "Ralsei") then
        messages["GENERIC/INTRO/1"] = "Here we go!"
        messages["GENERIC/INTRO/2"] = "We don't need to fight..."
        messages["GENERIC/INTRO/3"] = "Everyone, on guard!"
        
        messages["GENERIC/IDLE/1"] = "Um... hello?"
        messages["GENERIC/IDLE/2"] = "Are you there?"
        messages["GENERIC/IDLE/3"] = "I think they are away..."

        messages["GENERIC/HURT/1"] = "Ouch!"
        messages["GENERIC/HURT/2"] = "OW!"

        messages["GENERIC/TAUNT/1"] = "You won't beat us!"
        messages["GENERIC/TAUNT/2"] = "Your loss is prophesized!"
        messages["GENERIC/TAUNT/3"] = "Like all the others!"
        messages["GENERIC/TAUNT/4"] = "You don't scare me!"

        messages["GENERIC/CHEER/1"] = "Great work!"
        messages["GENERIC/CHEER/2"] = "I'm not down yet!"
        messages["GENERIC/CHEER/3"] = "Let's keep going!"

        messages["GENERIC/RAGE/1"] = "Aw, come on!"
        messages["GENERIC/RAGE/2"] = "I don't have nice words for this."
        messages["GENERIC/RAGE/3"] = "That was rude!"

        messages["GENERIC/WORRY/1"] = "[shake:1]Oh dear..."
        messages["GENERIC/WORRY/2"] = "[shake:1]Kris... Susie...!"
    elseif (name == "Noelle") then
        messages["GENERIC/INTRO/1"] = "Here goes nothing..."
        messages["GENERIC/INTRO/2"] = "R-Ready!"
        messages["GENERIC/INTRO/3"] = "Alright!"
        
        messages["GENERIC/IDLE/1"] = "...Uh... you there?"
        messages["GENERIC/IDLE/2"] = "I think they're away..."
        messages["GENERIC/IDLE/3"] = "Are you going to... do anything?"

        messages["GENERIC/HURT/1"] = "OUCH!"
        messages["GENERIC/HURT/2"] = "Ow..."

        messages["GENERIC/TAUNT/1"] = "Nice try, fahaha!"
        messages["GENERIC/TAUNT/2"] = "EEK! Get away!"
        messages["GENERIC/TAUNT/3"] = "Gotcha!"
        messages["GENERIC/TAUNT/4"] = "Stay down!"

        messages["GENERIC/CHEER/1"] = "I'm back!"
        messages["GENERIC/CHEER/2"] = "Here we go again..."
        messages["GENERIC/CHEER/3"] = "Alright!"

        messages["GENERIC/RAGE/1"] = "WHAT!?"
        messages["GENERIC/RAGE/2"] = "Oh COME ON-"
        messages["GENERIC/RAGE/3"] = "This is some holly jolly horse crap."

        messages["GENERIC/WORRY/1"] = "[shake:1]Uh oh..."
        messages["GENERIC/WORRY/2"] = "[shake:1]W-Wait, where's everybody else?"
    elseif (name == "Berdly") then
        messages["GENERIC/INTRO/1"] = "FEAR NOT! Your gallant warrior is here!"
        messages["GENERIC/INTRO/2"] = "En Guarde!"
        messages["GENERIC/INTRO/3"] = "A duel of brains, hmm?"
        
        messages["GENERIC/IDLE/1"] = "I see your small mind is slow to plot."
        messages["GENERIC/IDLE/2"] = "Would you hurry it up? Some of us have [wave:1]priorities."
        messages["GENERIC/IDLE/3"] = "Your sluggish actions leave me... unimpressed."

        messages["GENERIC/HURT/1"] = "Ow! L-Lucky hit!"
        messages["GENERIC/HURT/2"] = "That one didn't count!"

        messages["GENERIC/TAUNT/1"] = "Hah! Foolish."
        messages["GENERIC/TAUNT/2"] = "As easy as getting the 'dub' should be."
        messages["GENERIC/TAUNT/3"] = "The vain and evil shall fall!"
        messages["GENERIC/TAUNT/4"] = "It is simply too easy."

        messages["GENERIC/CHEER/1"] = "Heroes never die!"
        messages["GENERIC/CHEER/2"] = "Back in the fight- back in the race!"
        messages["GENERIC/CHEER/3"] = "Gamers don't die- we respawn!"

        messages["GENERIC/RAGE/1"] = "That is utterly unfair!"
        messages["GENERIC/RAGE/2"] = "What is this nonsense?"
        messages["GENERIC/RAGE/3"] = "Oh come on!"

        messages["GENERIC/WORRY/1"] = "[shake:1]It seems it is just you and I...!"
        messages["GENERIC/WORRY/2"] = "[shake:1]I will not fall to the likes of you!"
    elseif (name == "Knight") then
        messages["GENERIC/INTRO/1"] = "..."
        messages["GENERIC/INTRO/2"] = "..."
        messages["GENERIC/INTRO/3"] = "..."
        
        messages["GENERIC/IDLE/1"] = "..."
        messages["GENERIC/IDLE/2"] = "..."
        messages["GENERIC/IDLE/3"] = "..."

        messages["GENERIC/HURT/1"] = "..."
        messages["GENERIC/HURT/2"] = "..."

        messages["GENERIC/TAUNT/1"] = "..."
        messages["GENERIC/TAUNT/2"] = "..."
        messages["GENERIC/TAUNT/3"] = "..."
        messages["GENERIC/TAUNT/4"] = "..."

        messages["GENERIC/CHEER/1"] = "..."
        messages["GENERIC/CHEER/2"] = "..."
        messages["GENERIC/CHEER/3"] = "..."

        messages["GENERIC/RAGE/1"] = "..."
        messages["GENERIC/RAGE/2"] = "..."
        messages["GENERIC/RAGE/3"] = "..."

        messages["GENERIC/WORRY/1"] = "[shake:1]..."
        messages["GENERIC/WORRY/2"] = "[shake:1]..."
    elseif (name == "Jevil") then
        messages["GENERIC/INTRO/1"] = "UEE HEE HEE! CHAOS, CHAOS!"
        messages["GENERIC/INTRO/2"] = "LET THE NUMBERS GAME BEGIN, BEGIN!"
        messages["GENERIC/INTRO/3"] = "WHAT FUN, FUN!"
        
        messages["GENERIC/IDLE/1"] = "TOO SLOW, SLOW!"
        messages["GENERIC/IDLE/2"] = "GO, GO!"
        messages["GENERIC/IDLE/3"] = "NOT ENOUGH CHAOS, CHAOS!"

        messages["GENERIC/HURT/1"] = "UEE HEE HEE!"
        messages["GENERIC/HURT/2"] = "WHAT FUN, FUN INDEED!"

        messages["GENERIC/TAUNT/1"] = "CHAOS, CHAOS!"
        messages["GENERIC/TAUNT/2"] = "YOU'RE NO MATCH, MATCH!"
        messages["GENERIC/TAUNT/3"] = "TRY TO KEEP UP!"
        messages["GENERIC/TAUNT/4"] = "THE WORLD GOES ROUND AND ROUND, ROUND!"

        messages["GENERIC/CHEER/1"] = "I CAN DO ANYTHING!"
        messages["GENERIC/CHEER/2"] = "CHAOS, CHAOS!"
        messages["GENERIC/CHEER/3"] = "UEE HEE HEE!"

        messages["GENERIC/RAGE/1"] = "NOT FAIR, FAIR!"
        messages["GENERIC/RAGE/2"] = "THIS IS NOT OVER YET, YET!"
        messages["GENERIC/RAGE/3"] = "I'LL BE BACK, BACK!"

        messages["GENERIC/WORRY/1"] = "UEE HEE HEE!"
        messages["GENERIC/WORRY/2"] = "THE BELL TOLLS, TOLLS! BUT NOT FOR ME! UEE HEE HEE!"
    elseif (name == "Gerson" or name == "Old Man") then
        messages["GENERIC/INTRO/1"] = "What are you kids up to? GYEH HEH HEH"
        messages["GENERIC/INTRO/2"] = "Let's get those fellows!"
        messages["GENERIC/INTRO/3"] = "This'll be a good warmup!"
        
        messages["GENERIC/IDLE/1"] = "Take all the time you need, sonny."
        messages["GENERIC/IDLE/2"] = "It's alright- I'm a little slow sometimes too! GYEH HEH HE-"
        messages["GENERIC/IDLE/3"] = "Any day now!"

        messages["GENERIC/HURT/1"] = "YEOWCH!"
        messages["GENERIC/HURT/2"] = "Got me with that one!"

        messages["GENERIC/TAUNT/1"] = "GYEH HEH HEH!"
        messages["GENERIC/TAUNT/2"] = "Keep up, laddie!"
        messages["GENERIC/TAUNT/3"] = "Didn't see that one coming?"
        messages["GENERIC/TAUNT/4"] = "I'm old!"

        messages["GENERIC/CHEER/1"] = "Back at it!"
        messages["GENERIC/CHEER/2"] = "Can't even keep an old geezer down?"
        messages["GENERIC/CHEER/3"] = "GYEH EH HEH!"

        messages["GENERIC/RAGE/1"] = "Aw, fiddlesticks."
        messages["GENERIC/RAGE/2"] = "Well, they'll handle it."
        messages["GENERIC/RAGE/3"] = "I'm out!"

        messages["GENERIC/WORRY/1"] = "Hm."
        messages["GENERIC/WORRY/2"] = "...I see."
    elseif (name == "W.Cooler") then
        messages["GENERIC/INTRO/1"] = "buble"
        
        messages["GENERIC/IDLE/1"] = "booble"

        messages["GENERIC/HURT/1"] = "boble"

        messages["GENERIC/TAUNT/1"] = "bible"

        messages["GENERIC/CHEER/1"] = "bubble"

        messages["GENERIC/RAGE/1"] = "bloble"

        messages["GENERIC/WORRY/1"] = "[shake:1]buble"
    elseif (name == "Evan") then
        messages["GENERIC/INTRO/1"] = "H-Here we go..."
        messages["GENERIC/INTRO/2"] = "R-Ready!"
        messages["GENERIC/INTRO/3"] = "B-Brace yourselves...!"
        
        messages["GENERIC/IDLE/1"] = "..."
        messages["GENERIC/IDLE/2"] = "I-It's okay! I'm p-patient."
        messages["GENERIC/IDLE/3"] = "Take y-your time..."

        messages["GENERIC/HURT/1"] = "Ow..."
        messages["GENERIC/HURT/2"] = "That- y-you didn't see that."

        messages["GENERIC/TAUNT/1"] = "H-Ha!"
        messages["GENERIC/TAUNT/2"] = "I d-did it?"
        messages["GENERIC/TAUNT/3"] = "I'm n-not afraid of you!"
        messages["GENERIC/TAUNT/4"] = "Back o-off!"

        messages["GENERIC/CHEER/1"] = "I'm b-back!"
        messages["GENERIC/CHEER/2"] = "S-Sorry, I fell for a b-bit..."
        messages["GENERIC/CHEER/3"] = "I'm a-alive?"

        messages["GENERIC/RAGE/1"] = "Aw..."
        messages["GENERIC/RAGE/2"] = "That's not v-very fair..."
        messages["GENERIC/RAGE/3"] = "...okay..."

        messages["GENERIC/WORRY/1"] = "[shake:1]G-Guys!? U-Uh..."
        messages["GENERIC/WORRY/2"] = "[shake:1]...oh n-no..."
    elseif (name == "Cassidy") then
        messages["GENERIC/INTRO/1"] = "Let's go!"
        messages["GENERIC/INTRO/2"] = "Quick and easy!"
        messages["GENERIC/INTRO/3"] = "Knock 'em dead!"
        
        messages["GENERIC/IDLE/1"] = "...You stupid?"
        messages["GENERIC/IDLE/2"] = "Hurry uuup!"
        messages["GENERIC/IDLE/3"] = "C'mon, c'mon!"

        messages["GENERIC/HURT/1"] = "Ow..."
        messages["GENERIC/HURT/2"] = "H-Hey, you- I LET THEM HIT ME OKAY?!"

        messages["GENERIC/TAUNT/1"] = "Too easy!"
        messages["GENERIC/TAUNT/2"] = "Get wrecked."
        messages["GENERIC/TAUNT/3"] = "*Blows up pancakes with mind*"
        messages["GENERIC/TAUNT/4"] = "NERRDD"

        messages["GENERIC/CHEER/1"] = "Back at it!"
        messages["GENERIC/CHEER/2"] = "I'm not THAT frail!"
        messages["GENERIC/CHEER/3"] = "I'm baaaack!"

        messages["GENERIC/RAGE/1"] = "OH COME ON, MAN"
        messages["GENERIC/RAGE/2"] = "REALLY!?"
        messages["GENERIC/RAGE/3"] = "Bullshit."

        messages["GENERIC/WORRY/1"] = "[shake:1]...It'll be fine."
        messages["GENERIC/WORRY/2"] = "[shake:1]I can handle this..."
    end
    TableUtils.merge(member.chat_messages, messages)
end

---@param battler PartyBattler
---@param btn_types table
function EverParty:getActionButtons(battler, btn_types)
    local index = TableUtils.getIndex(Game.battle.party, battler)
    local row = math.floor((index and index or 1) / self:styleRowMax())
    if self:styleRowMax() > 3 and self:isWideStyle() and (self:getActionBoxScale(row) < 1 and self:getActionBoxScale(row) > 0) then
        if TableUtils.contains(btn_types, "act") and TableUtils.contains(btn_types, "magic") then
            TableUtils.removeValue(btn_types, "act")
            battler.flattened_act = true
        end
    end
end

function EverParty:postUpdate()
    if (#Game.party ~= self.prev_party_size) then
        for i, member in ipairs(Game.party) do
            if not (member.default_chat_initialized) then
                self:registerDefaultChatMessages(member)
            end
        end
    end
end

return EverParty
