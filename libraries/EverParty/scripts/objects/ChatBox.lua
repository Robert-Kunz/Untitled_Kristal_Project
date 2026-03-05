---@class ChatBox : Object
local ChatBox, super = Class(Object)

function ChatBox:init(x, y, width, height)
    super.init(self, x, y, width, height)
    self.chat_history = {}
    self.visible_messages = {}
    self.font = Assets.getFont("plain")
    self.pending_messages = {}
    self.currently_typing = {}
    self.typing_text = Text("", 5, self.height, 200, 100, {font = "plain", font_size = 0.5, color= {0.5, 0.5, 0.5, 1}, auto_size = true})
    self:addChild(self.typing_text)
    self:setCutout(nil,0,nil,nil)
end

function ChatBox:displayMessage(message)
    if not (EverParty:getConfig("ingame_chat")) then
        return
    end
    if (self.visible) then
        Assets.playSound("eggshort", 1, MathUtils.random(0.9, 1.05))
    end
    table.insert(self.chat_history, message)
    local newMessage = Text(message, 10, self.height, 142, 100, {font = "eb", font_size = 16, auto_size = true})
    newMessage.wrap = true
    self:addChild(newMessage)
    newMessage:shake(2, 0, 0.5)
    local previousMessageHeight = self.height
    local shouldPop = false
    table.insert(self.visible_messages, 1, newMessage)
    for i, message in ipairs(self.visible_messages) do
        message.y = previousMessageHeight - message:getTextHeight()
        previousMessageHeight = message.y
        if (message.y < -message:getTextHeight() - 5) then
            shouldPop = true
        end
    end
    if shouldPop then
        local removed = table.remove(self.visible_messages)
        removed:remove()
    end
end

function ChatBox:pushMessage(who, message, delay)
    if (message == "") then
        return
    end
    if (not delay) and not StringUtils.contains(who, "Kris") then
        self:displayMessage(who .. ": " .. message)
    else
        table.insert(self.currently_typing, who)
        Game.battle.timer:after(delay, function ()
            if (not StringUtils.contains(who, "Kris")) then self:displayMessage(who .. ": " .. message) end
            TableUtils.removeValue(self.currently_typing, who)
        end)
    end
end

function ChatBox:pushMessages(messages, delay, randomize)
    for k, message in pairs(messages) do
        if (message ~= "") then
            local who = k
            table.insert(self.pending_messages, who .. ": " .. message)
            table.insert(self.currently_typing, who)
        end
    end
    if (#self.pending_messages == 0) then return end
    --Kristal.Console:log ("yay")
    self.pending_messages = TableUtils.shuffle(self.pending_messages)
    local currentTimer = 0
    Game.battle.timer:doWhile(function () return #self.pending_messages > 0 end, function()
        if (currentTimer <= 0) then
            currentTimer = delay + (randomize and MathUtils.random(-1, 1) or 0)
            local message = table.remove(self.pending_messages)
            local who = StringUtils.split(message, "]:")[1]
            --Kristal.Console:log("`"..who.."]`")
            TableUtils.removeValue(self.currently_typing, who .. "]")
            if (message) and not (StringUtils.contains(who, "Kris")) then
                self:displayMessage(message)
            end
        else
            currentTimer = currentTimer - DT
        end
    end, function () end)
end

function ChatBox:update()
    super.update(self)
    if (#self.currently_typing > 0) then
        local typing = "is typing [wave:1]..."
        local typers = ""
        if (#self.currently_typing > 3) then
            typing = "several people are typing [wave:1]..."
        else
            for i, typer in ipairs(self.currently_typing) do
                if (i > 1) then
                    typing = "are typing [wave:1]..."
                end
                if (i > 1) and (i == #self.currently_typing) then
                    typers = typers .. "and " .. typer .. " "
                else
                    typers = typers .. typer .. ", "
                end
            end
        end
        self.typing_text.visible = true
        if (self.typing_text.text ~= typers..typing) then
            self.typing_text:setText(typers..typing)
        end
    else
        self.typing_text:setText("")
    end
end

function ChatBox:draw()
    
    Draw.setColor(PALETTE["action_fill"])
    Draw.rectangle("fill", 0, 0, 200, 200)
    Draw.setColor(PALETTE["action_strip"])
    love.graphics.setLineWidth(2)
    love.graphics.line(0, 0, 0, 200)
    love.graphics.setLineWidth(1)
    super.draw(self)
end

return ChatBox