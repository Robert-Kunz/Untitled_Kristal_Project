--- HOOK EXPLANATION:
--- This ensures that battleboxes are correctly positioned for indices beyond 3, which they normally wouldn't be.

---@class BattleUI : Object
---@field two_x_two boolean     Boolean that determines whether to draw the battleboxes in a 2x configuration rather than compressing them in an ugly way or having uneven rows. Explicitly for parties divisible by 4.
---@field uneven_rows boolean
---@field chat_box ChatBox
local BattleUI, super = HookSystem.hookScript(BattleUI)

---todo: add roulette mode ("later" [medic voice])
---todo: also add battlecard mode
function BattleUI:init()
    super.init(self)
    self.uneven_rows = false
    self.chat_box = ChatBox(440, 365, 100, 100)
    self.chat_box:setLayer(BATTLE_LAYERS["top"])
    Game.battle:addChild(self.chat_box)
    self.chat_box.visible = EverParty:getConfig("ingame_chat")

    local row_count = (EverParty:getConfig("ui_style") == "ROULETTE") and 2 or ((EverParty:getConfig("ui_style") == "STANDARD" or EverParty:getConfig("ui_style") == "CLASSIC") and math.ceil(#Game.battle.party / EverParty:getRowCheckSize())) or 1
    self.two_x_two = EverParty:getRowCheckSize() == 2
    local row_size = EverParty:getRowCheckSize()
    -- ugly duplicated code but not really any way around it :( bigsad
    function getSizeOffset(num, row_size)
        local size_offset = 0
        local box_gap = 0
        if num == 3 then
            size_offset = 0
            box_gap = 0
        elseif (num == 2) or (row_size == 2) then
            size_offset = 108
            box_gap = 1
            if Game:getConfig("oldUIPositions") then
                size_offset = 106
                box_gap = 7
            end
        elseif num == 1 then
            size_offset = 213
            box_gap = 0
        elseif num > 3 and row_size > 3 and EverParty:isWideStyle() and (EverParty:getConfig("ui_style") ~= "ROULETTE") then
            box_gap = -73 * EverParty:getActionBoxScale()
        end
        return size_offset, box_gap
    end

    for index,battler in ipairs(Game.battle.party) do
        local row_index = (index <= row_size) and 0 or (math.floor((index-1)/row_size)) % row_count
        local row_offset = row_index * (Game:getConfig("oldUIPositions") and 36 or 37)
        local effective_row_size = self.two_x_two and 2 or MathUtils.clamp(#Game.battle.party - (row_size * row_index), 1, row_size)
        --Kristal.Console:log(row_index)
        if (effective_row_size < row_size) then
            self.uneven_rows = true
        end
        local row_specific_size_offset, row_specific_box_gap = getSizeOffset(effective_row_size, row_size)
        -- ((row_offset == 0) or (#Game.battle.party >= row_size * row_offset)) and #Game.battle.party or 
        if (self.two_x_two and (index % 3 == 0)) then
            --todo: no idea if this is right and i am shit at math so ill have to test this
            row_offset = ((math.ceil(index / 2) - 1) * (Game:getConfig("oldUIPositions") and 36 or 37))
        end
        local found = nil
        for dex, box in ipairs(self.action_boxes) do
            ---@type PartyBattler
            local box_battler = box.battler
            if (box_battler.chara:getName() == battler.chara:getName()) then
                found = dex
                break
            end
        end
        local x_indexoffset = self.two_x_two and ((index - 1) % 2) or ((index - 1) % row_size)
        if (found) then
            ---@type ActionBox
            local action_box = self.action_boxes[found]
            action_box.x = row_specific_size_offset + x_indexoffset * (213 + row_specific_box_gap)
            action_box.y = action_box.y - row_offset
            action_box:setLayer(action_box.layer + (EverParty:isWideStyle() and (row_count - (math.ceil(index / (self.two_x_two and 2 or row_size) - 1))) or 0))
        else
            -- should never be this. why would it be this? the original init doesn't care about the party count! but i need to be certain just in case someone does something stupid so this is here
            local action_box = ActionBox(row_specific_size_offset+ x_indexoffset * (213 + row_specific_box_gap), -row_offset, index, battler)
            self:addChild(action_box)
            action_box:setLayer(action_box.layer + (row_count - (math.ceil(index / (self.two_x_two and 2 or row_size) - 1))))
            table.insert(self.action_boxes, action_box)
            battler.chara:onActionBox(action_box, false)
        end
    end
end

function BattleUI:update()
    super.update(self)
    self.chat_box.y = self.y + 40
    self.chat_box.visible = (not TableUtils.contains({"MENUSELECT", "ENEMYSELECT", "PARTYSELECT", "CUTSCENE"}, Game.battle.state)) and EverParty:getConfig("ingame_chat")
end
function BattleUI:updateRow()
end

--- REASON FOR HOOK : gotta draw them backgrounds, man
--- Todo: roulette mode
function BattleUI:drawActionStrip()
    if (#Game.battle.party > 3) and EverParty:isWideStyle() then
        local rows = (self.two_x_two and #Game.battle.party == 4 and math.ceil(#Game.battle.party / 2) or math.ceil(#Game.battle.party / EverParty:getRowCheckSize())) - 1
        if (EverParty:getConfig("ui_style") == "ROULETTE") then
            rows = math.min(rows, 0)
        end
        --print(rows)
        local current_row = rows
        while (current_row > 0) do
            local current_offset = current_row * (Game:getConfig("oldUIPositions") and 36 or 37)
            --print (current_offset)
            -- Draw the top line of the action strip
            Draw.setColor(PALETTE["action_strip"])
            love.graphics.rectangle("fill", 0, (Game:getConfig("oldUIPositions") and 1 or 0) - current_offset, 640, (Game:getConfig("oldUIPositions") and 3 or 2))
            -- Draw the background of the action strip
            Draw.setColor(PALETTE["action_fill"])
            love.graphics.rectangle("fill", 0, (Game:getConfig("oldUIPositions") and 4 or 2) - current_offset, 640, (Game:getConfig("oldUIPositions") and 33 or 35))
            current_row = current_row - 1
        end

        --draw the original after just to be safe
    end
    super.drawActionStrip(self)
end

return BattleUI