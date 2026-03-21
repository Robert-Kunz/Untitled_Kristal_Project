local spell, super = Class(Spell, "Deletion")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Delete"
    -- Name displayed when cast (optional)
    self.cast_name = "Delete"

    -- Battle description
    self.effect = "It's...\nGone..."
    -- Menu description
    self.description =
    "A strong Spell capable of [color:red]deleting[color:reset] any Enemy.\nDraws Power from the User's Soul."

    -- TP cost
    self.cost = 100

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = { "Fatal" }
    --replaces the usual casting animation
    self.cast_anim = "battle/deletion"
end

function spell:getCastMessage(user, target)
    --checks if Fifty is among the enemies, if yes, doesn't display any cast message
    if Game.battle:getEnemyBattler("Fifty") or Game.battle:getEnemyBattler("Fifty_Birthday") then
        return nil
    end
    return ("* " + user.chara:getName() + " cast Deletion!")
end

function spell:onCast(user, target)
    --checks if Fifty is among the enemies, if yes, doesn't actually go further with the spell
    if Game.battle:getEnemyBattler("Fifty") or Game.battle:getEnemyBattler("Fifty_Birthday") then
        Game.battle:startActCutscene("Fifty", "Deletion")
    else
        --checks if Barracuda is the target, if so, makes him play a certain animation
        if target == Game.battle:getEnemyBattler("Barracuda") then
            target:setAnimation("deletion_block")
        end
        local buster_finished = false
        local anim_finished = false
        -- Can add a delay between when the blast is sent out and the animation is finished
        Game.battle.timer:after(0, function()
            Assets.playSound("rudebuster_swing")
            local x, y = user:getRelativePos(user.width, user.height / 2 - 10, Game.battle)
            local tx, ty = target:getRelativePos(target.width / 2, target.height / 2, Game.battle)
            -- once the blast hits, executes further code
            local blast = Whack(false, x, y, tx, ty, function(play_sound)
                if play_sound then
                    Assets.playSound("scytheburst")
                end
                target:flash()
                if target == Game.battle:getEnemyBattler("Barracuda") then
                    target:hurt(0, user)
                else
                    target:hurt(math.huge, user, target.onDefeatFatal)
                end
                -- checks again if target is barracuda, if so, starts animations for both barracuda and caster, then starts a cutscene
                if target == Game.battle:getEnemyBattler("Barracuda") then
                    target:setAnimation("deletion_delete")
                    user:setAnimation("battle/idle")
                    Game.battle:startActCutscene("Barracuda", "Deletion")
                end
                Game.battle:finishAction()
            end)
            blast.layer = BATTLE_LAYERS["above_ui"]
            Game.battle:addChild(blast)
        end)
        return false
    end
end

return spell
