local DarkEquipMenu, super = HookSystem.hookScript(DarkEquipMenu)

function DarkEquipMenu:update()
    if self.state == "ITEMS" then
        if Input.pressed("cancel") then
            self.state = "SLOTS"

            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()

            self:updateDescription()
            return
        end
        local type = self:getCurrentItemType()
        local max_items = self:getMaxItems()
        local old_selected = self.selected_item[type]
        if Input.pressed("up", true) then
            self.selected_item[type] = self.selected_item[type] - 1
        end
        if Input.pressed("down", true) then
            self.selected_item[type] = self.selected_item[type] + 1
        end
        self.selected_item[type] = MathUtils.clamp(self.selected_item[type], 1, max_items)
        if self.selected_item[type] ~= old_selected then
            local min_scroll = math.max(1, self.selected_item[type] - 5)
            local max_scroll = math.min(math.max(1, max_items - 5), self.selected_item[type])
            self.item_scroll[type] = MathUtils.clamp(self.item_scroll[type], min_scroll, max_scroll)

            self.ui_move:stop()
            self.ui_move:play()

            self:updateDescription()
        end
        if Input.pressed("confirm") then
            self:react()
            local item, party = self:getSelectedItem(), self.party:getSelected()
            if not self:canEquipSelected() then
                self.ui_cant_select:stop()
                self.ui_cant_select:play()
            else
                local swap_with = (self.selected_slot == 1) and party:getWeapon() or
                    party:getArmor(self.selected_slot - 1)

                local can_continue = true

                if item and (not item:onEquip(party, swap_with)) then can_continue = false end
                if swap_with and (not swap_with:onUnequip(party, item)) then can_continue = false end
                if (not party:onEquip(item, swap_with)) then can_continue = false end
                if (not party:onUnequip(swap_with, item)) then can_continue = false end

                -- If one of the functions returned false, don't continue

                if (not can_continue) then
                    self.ui_cant_select:stop()
                    self.ui_cant_select:play()
                    return
                end

                Assets.playSound("equip")

                if self.selected_slot == 1 then
                    if not item then item = Registry.createItem("Default") end          -- if no new_equip then new_equip = default
                    if swap_with and swap_with.id == "Default" then swap_with = nil end -- if old_equip.id == default.id then old_equip = nil
                    party:setWeapon(item)
                else
                    party:setArmor(self.selected_slot - 1, item)
                end

                Game.inventory:setItem(self:getCurrentStorage(), self.selected_item[type], swap_with)

                self.state = "SLOTS"
                self:updateDescription()
            end
        end
        return super.super.update(self)
    end
    super.update(self)
end

return DarkEquipMenu
