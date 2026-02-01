local PartyBattler, super = HookSystem.hookScript(PartyBattler)

function PartyBattler:hurt(amount, exact, color, options)
    options = options or {}

    local swoon = options["swoon"]

    if not options["all"] then
        Assets.playSound("hurt")
        if not exact then
            amount = self:calculateDamage(amount)
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))
        end

        self:removeHealth(amount, swoon)
    else
        -- We're targeting everyone.
        if not exact then
            amount = self:calculateDamage(amount)
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))

            if self.defending then
                amount = math.ceil((3 * amount) / 4) -- Slightly different than the above
            end
        end

        self:removeHealthBroken(amount, swoon) -- Use a separate function for cleanliness
    end

    if (self.chara:getHealth() <= 0) then
        -- checks if the character downed is Honeywisp, if yes, shows different downing message.
        if self.chara.id == "Honeywisp" then
            self:statusMessage("msg", swoon and "swoon" or "gone", color, true)
        else
            self:statusMessage("msg", swoon and "swoon" or "down", color, true)
        end
    else
        self:statusMessage("damage", amount, color, true)
    end

    self.hurt_timer = 0
    Game.battle:shakeCamera(4)

    if (not self.defending) and (not self.is_down) then
        self.sleeping = false
        self.hurting = true
        self:toggleOverlay(true)
        self.overlay_sprite:setAnimation("battle/hurt", function()
            if self.hurting then
                self.hurting = false
                self:toggleOverlay(false)
            end
        end)
        if not self.overlay_sprite.anim_frames then -- backup if the ID doesn't animate, so it doesn't get stuck with the hurt animation
            Game.battle.timer:after(0.5, function()
                if self.hurting then
                    self.hurting = false
                    self:toggleOverlay(false)
                end
            end)
        end
    end
end

return PartyBattler
