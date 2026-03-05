---@alias chattype
---| "IDLE"
---| "HURT"
---| "TAUNT"
---| "CHEER"
---| "RAGE"
---| "WORRY"
---| "INTRO"

---@class PartyMember : Class
---@field chat_messages table<string, string>
---@field default_chat_initialized boolean
---
local PartyMember, super = HookSystem.hookScript(PartyMember)

function PartyMember:init()
    super.init(self)
    self.chat_messages = {}
    self.default_chat_initialized = false
end


---Retrieves an appropriate chat message for the situation, or an empty string if there isn't one. Used for the Battlecard Party Chat.
---EXAMPLE:
---=Jevil:getBattleChatMessage("KNIGHT", "TAUNT")
---"UEE HEE HEE! CHAOS, CHAOS- IT'S TIME FOR A NUMBERS GAME, ONE YOU WON'T BE WINNING, WINNING!"
---
---@param context string A string representing the context- used for things like custom encounter reactions. Example: KNIGHT. GENERIC is default.
---
---@param type chattype A string representing the type of message.
---
---@return string
function PartyMember:getBattleChatMessage(context, type)
    if (not context) then
        context = "GENERIC"
    end
    if (not type) then
        type = "IDLE"
    end
    local search = context .. "/" .. type
    local fallback_search = "GENERIC/" .. type
    local potential_messages = {}
    local fallback_messages = {}
    for i, key in ipairs(TableUtils.getKeys(self.chat_messages)) do
        if (StringUtils.contains(key, search)) then
            table.insert(potential_messages, key)
        elseif (StringUtils.contains(key, fallback_search)) then
            table.insert(fallback_messages, key)
        end
    end

    if #potential_messages == 0 then
        if #fallback_messages > 0 then
            return self.chat_messages[TableUtils.pick(fallback_messages)]
        end
        return ""
    end
    return self.chat_messages[TableUtils.pick(potential_messages)]
end

---@param message string
---@param context string
---@param type chattype
---@param suffix string
function PartyMember:addBattleChatMessage(message, context, type, suffix)
    self.chat_messages[context .. "/" .. type .. "/" .. suffix] = message
end

function PartyMember:onAttackHit(enemy, damage)
    if (super.onAttackHit) then super.onAttackHit(self, enemy, damage) end
    Game.battle.battle_ui.chat_box:pushMessage(self:coloredName(), self:getBattleChatMessage(Game.battle.encounter:getChatContext(), "TAUNT"), MathUtils.randomInt(1, 4))
end

---@return string
function PartyMember:coloredName()
    return "[color:"..ColorUtils.RGBToHex(self.color[1], self.color[2], self.color[3]).."]"..self.name.."[color:reset]"
end

return PartyMember