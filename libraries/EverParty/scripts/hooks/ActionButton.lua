local ActionButton, super = HookSystem.hookScript(ActionButton)

if (EverParty:getConfig("ui_style") ~= "CLASSIC") then
    return ActionButton
end

---unfortunate overwrite :(
function ActionButton:select()
    if Game.battle.encounter:onActionSelect(self.battler, self) then return end
    if Kristal.callEvent(KRISTAL_EVENT.onActionSelect, self.battler, self) then return end
    if self.type == "fight" then
        Game.battle:setState("ENEMYSELECT", "ATTACK")
    elseif self.type == "act" then
        Game.battle:setState("ENEMYSELECT", "ACT")
    elseif self.type == "magic" then
        Game.battle:clearMenuItems()

        -- First, register X-Actions as menu items.

        if (self.battler.flattened_act) then
            local spell = {
                ["name"] = "ACT",
                ["target"] = "none",
                ["id"] = -1,
                ["default"] = true,
                ["party"] = {},
                ["tp"] = 0
            }

            Game.battle:addMenuItem({
                ["name"] = "ACT",
                ["tp"] = 0,
                ["description"] = "Not\nmagic",
                ["color"] = function () return {Utils.mergeColor({self.battler.chara:getXActColor()}, COLORS.white, 0.5 + math.sin(Game.battle.pacify_glow_timer / 6) * 0.5)} end,
                ["data"] = spell,
                ["callback"] = function(menu_item)
                    Game.battle:setState("ENEMYSELECT", "ACT")
                end
            })
        end

        if Game.battle.encounter.default_xactions and self.battler.chara:hasXAct() then
            local spell = {
                ["name"] = Game.battle.enemies[1]:getXAction(self.battler),
                ["target"] = "xact",
                ["id"] = 0,
                ["default"] = true,
                ["party"] = {},
                ["tp"] = 0
            }

            Game.battle:addMenuItem({
                ["name"] = self.battler.chara:getXActName() or "X-Action",
                ["tp"] = 0,
                ["color"] = {self.battler.chara:getXActColor()},
                ["data"] = spell,
                ["callback"] = function(menu_item)
                    Game.battle.selected_xaction = spell
                    Game.battle:setState("ENEMYSELECT", "XACT")
                end
            })
        end

        for id, action in ipairs(Game.battle.xactions) do
            if action.party == self.battler.chara.id then
                local spell = {
                    ["name"] = action.name,
                    ["target"] = "xact",
                    ["id"] = id,
                    ["default"] = false,
                    ["party"] = {},
                    ["tp"] = action.tp or 0
                }

                Game.battle:addMenuItem({
                    ["name"] = action.name,
                    ["tp"] = action.tp or 0,
                    ["description"] = action.description,
                    ["color"] = action.color or {1, 1, 1, 1},
                    ["data"] = spell,
                    ["callback"] = function(menu_item)
                        Game.battle.selected_xaction = spell
                        Game.battle:setState("ENEMYSELECT", "XACT")
                    end
                })
            end
        end

        -- Now, register SPELLs as menu items.
        for _,spell in ipairs(self.battler.chara:getSpells()) do
            ---@type table|function
            local color = spell.color or {1, 1, 1, 1}
            if spell:hasTag("spare_tired") then
                local has_tired = false
                for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                    if enemy.tired then
                        has_tired = true
                        break
                    end
                end
                if has_tired then
                    color = {0, 178/255, 1, 1}
                    if Game:getConfig("pacifyGlow") then
                        color = function ()
                            return Utils.mergeColor({0, 0.7, 1, 1}, COLORS.white, 0.5 + math.sin(Game.battle.pacify_glow_timer / 4) * 0.5)
                        end
                    end
                end
            end
            Game.battle:addMenuItem({
                ["name"] = spell:getName(),
                ["tp"] = spell:getTPCost(self.battler.chara),
                ["unusable"] = not spell:isUsable(self.battler.chara),
                ["description"] = spell:getBattleDescription(),
                ["party"] = spell.party,
                ["color"] = color,
                ["data"] = spell,
                ["callback"] = function(menu_item)
                    Game.battle.selected_spell = menu_item

                    if not spell.getTarget or not spell:getTarget() or spell:getTarget() == "none" then
                        Game.battle:pushAction("SPELL", nil, menu_item)
                    elseif spell:getTarget() == "ally" then
                        Game.battle:setState("PARTYSELECT", "SPELL")
                    elseif spell:getTarget() == "enemy" then
                        Game.battle:setState("ENEMYSELECT", "SPELL")
                    elseif spell:getTarget() == "party" then
                        Game.battle:pushAction("SPELL", Game.battle.party, menu_item)
                    elseif spell:getTarget() == "enemies" then
                        Game.battle:pushAction("SPELL", Game.battle:getActiveEnemies(), menu_item)
                    end
                end
            })
        end

        Game.battle:setState("MENUSELECT", "SPELL")
    elseif self.type == "item" then
        Game.battle:clearMenuItems()
        for i,item in ipairs(Game.inventory:getStorage("items")) do
            Game.battle:addMenuItem({
                ["name"] = item:getName(),
                ["unusable"] = item.usable_in ~= "all" and item.usable_in ~= "battle",
                ["description"] = item:getBattleDescription(),
                ["data"] = item,
                ["callback"] = function(menu_item)
                    Game.battle.selected_item = menu_item

                    if not item:getTarget() or item:getTarget() == "none" then
                        Game.battle:pushAction("ITEM", nil, menu_item)
                    elseif item:getTarget() == "ally" then
                        Game.battle:setState("PARTYSELECT", "ITEM")
                    elseif item:getTarget() == "enemy" then
                        Game.battle:setState("ENEMYSELECT", "ITEM")
                    elseif item:getTarget() == "party" then
                        Game.battle:pushAction("ITEM", Game.battle.party, menu_item)
                    elseif item:getTarget() == "enemies" then
                        Game.battle:pushAction("ITEM", Game.battle:getActiveEnemies(), menu_item)
                    end
                end
            })
        end
        if #Game.battle.menu_items > 0 then
            Game.battle:setState("MENUSELECT", "ITEM")
        end
    elseif self.type == "spare" then
        Game.battle:setState("ENEMYSELECT", "SPARE")
    elseif self.type == "defend" then
        Game.battle:pushAction("DEFEND", nil, {tp = -Game.battle:getDefendTension(self.battler)})
    end
end

return ActionButton