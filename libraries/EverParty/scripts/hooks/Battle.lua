--- HOOK EXPLANATION:
--- This creates the party battlers, and also handles the turn order chaos. Surprisingly low amount changed here, and should never cause issues. Should.

---@class Battle : Object
---@field max_party_size number
---@field turn_order_chaos boolean
---@field action_scroll number
local Battle, super = HookSystem.hookScript(Battle)

function Battle:init(...)
    self.max_party_size = EverParty:getConfig("party_limit") or 0 -- if zero we'll just ignore it
    self.turn_order_chaos = EverParty:getConfig("chaos_mode")
    self.action_scroll = 1 / 4
    super.init(self, ...)
end

function Battle:nextParty()
    super.nextParty(self)
    if (not StringUtils.contains(self.state, "SELECT")) then
        self.action_scroll = 0
    else
        self.action_scroll = self.current_selecting / 4
    end
end

function Battle:previousParty()
    super.previousParty(self)
    self.action_scroll = self.current_selecting / 4
end

function Battle:onActionSelectState()
    if not self.started then
        if (EverParty:getConfig("ingame_chat")) then
            local chatbox = self.battle_ui.chat_box
            local context = self.encounter:getChatContext()
            local messages = {}
            for i, member in ipairs(self.party) do
                messages[member:coloredName()] = member.chara:getBattleChatMessage(context, "INTRO")
            end
            chatbox:pushMessages(messages, 1, true)
        end
    end
    super.onActionSelectState(self)
end

function Battle:checkGameOver()
    local battlers_up = {}
    for _, battler in ipairs(self.party) do
        if not battler.is_down then
            table.insert(battlers_up, battler)
        end
    end
    if (#battlers_up == 1 and #self.party > 1) then
        local survivor = battlers_up[1]
        self.battle_ui.chat_box:pushMessage(survivor:coloredName(), survivor.chara:getBattleChatMessage(self.encounter:getChatContext(), "WORRY"), MathUtils.randomInt(1, 4))
    end
    super.checkGameOver(self)
end

function Battle:createPartyBattlers()
    super.createPartyBattlers(self)
    if (#Game.party > 3) and ((self.max_party_size > 3) or self.max_party_size == 0) then
        for i = 4, #Game.party do
            local party_member = Game.party[i]

            -- note: i probably don't need to copy this code, however there is a chance that some fuckery is occuring that would make the player an index beyond 3, and I'd rather not take my chances
            if Game.world.player and Game.world.player.visible and Game.world.player.actor.id == party_member:getActor().id then
                -- Create the player battler
                local player_x, player_y = Game.world.player:getScreenPos()
                local player_battler = PartyBattler(party_member, player_x, player_y)
                player_battler:setAnimation("battle/transition")
                self:addChild(player_battler)
                table.insert(self.party,player_battler)
                table.insert(self.party_beginning_positions, {player_x, player_y})
                self.party_world_characters[party_member.id] = Game.world.player

                Game.world.player.visible = false
            else
                local found = false
                for _,follower in ipairs(Game.world.followers) do
                    if follower.visible and follower.actor.id == party_member:getActor().id then
                        local chara_x, chara_y = follower:getScreenPos()
                        local chara_battler = PartyBattler(party_member, chara_x, chara_y)
                        chara_battler:setAnimation("battle/transition")
                        self:addChild(chara_battler)
                        table.insert(self.party, chara_battler)
                        table.insert(self.party_beginning_positions, {chara_x, chara_y})
                        self.party_world_characters[party_member.id] = follower

                        follower.visible = false

                        found = true
                        break
                    end
                end
                if not found then
                    local chara_battler = PartyBattler(party_member, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
                    chara_battler:setAnimation("battle/transition")
                    self:addChild(chara_battler)
                    table.insert(self.party, chara_battler)
                    table.insert(self.party_beginning_positions, {chara_battler.x, chara_battler.y})
                end
            end
        end
    end
    if self.turn_order_chaos then
        self.party = TableUtils.shuffle(self.party)
    end
end

return Battle