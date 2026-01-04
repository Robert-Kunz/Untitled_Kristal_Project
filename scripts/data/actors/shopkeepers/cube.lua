local actor, super = Class(Actor, "shopkeepers/cube")

function actor:init()
    super.init(self)

    self.name = "Cube"

    self.width = 96
    self.height = 114

    self.path = "shopkeepers/cube"
    self.default = "idle"

    self.animations = {
        "idle"
    }

    self.talk_sprites = {
        ["talk"] = 0.125,
        ["sad"] = 0.125,
        ["Thought"] = 0.125,
        ["embarrassed"] = 0.125,
        ["scared"] = 0.125
    }
end

function actor:onTalkStart(text, sprite)
    if sprite.sprite == "idle" then
        sprite:setSprite("talk")
    elseif sprite.sprite == "sad" then
        sprite:setSprite("sad")
    elseif sprite.sprite == "Thought" then
        sprite:setSprite("Thought")
    elseif sprite.sprite == "embarrassed" then
        sprite:setSprite("embarrassed")
    elseif sprite.sprite == "scared" then
        sprite:setSprite("scared")
    elseif sprite.sprite == "concerned" then
        sprite:setSprite("concerned")
    end
end

function actor:onTalkEnd(text, sprite)
    if sprite.sprite == "talk" then
        sprite:setAnimation("idle")
    elseif sprite.sprite == "sad" then
        sprite:setAnimation("sad")
    elseif sprite.sprite == "sad" then
        sprite:setAnimation("Thought")
    elseif sprite.sprite == "embarrassed" then
        sprite:setAnimation("embarrassed")
    elseif sprite.sprite == "scared" then
        sprite:setSprite("scared")
    elseif sprite.sprite == "concerned" then
        sprite:setSprite("concerned")
    end
end

return actor