local grow, super = Class(Wave)

function grow:onStart()
end

function grow:update()
    -- Code here gets called every frame

    super.update(self)
end

function grow:beforeEnd()
    --Game.battle:startCutscene("Barracuda", "power")
    Assets.playSound("bomb")
    return false
end

function grow:onEnd(death)
    Game.battle:startCutscene("Barracuda", "power")
    return false
end

return grow
