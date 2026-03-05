---@class PartialSprite : Sprite
---@field topcut number
---@field botcut number
---@field leftcut number
---@field rightcut number
local PartialSprite, super = Class(Sprite)

function PartialSprite:init(texture, x, y, width, height, path, topcut, botcut, leftcut, rightcut)
    super.init(self, texture, x, y, width, height, path)
    self.topcut = topcut or 0
    self.botcut = botcut or 0
    self.leftcut = leftcut or 0
    self.rightcut = rightcut or 0
    self.cutout_top = topcut or 0
    self.cutout_bottom = botcut or 0
    self.cutout_left = leftcut or 0
    self.cutout_right = rightcut or 0

    self.lerpProgress = 1
    self.ease_type = "linear"
    self.lerpProgress = 1
    self.ease_type = "linear"
end

function PartialSprite:lerpCut(top, bottom, left, right, time, ease_type)
    self.topcut = top
    self.botcut = bottom
    self.rightcut = right
    self.leftcut = left
    if (not time) or (time == 0) then
        self:setCutout(top, bottom, left, right)
        return
    end
    self.lerpProgress = 0
    self.ease_type = ease_type and ease_type or "linear"
end

function PartialSprite:update()
    super.update(self)
    self.lerpProgress = MathUtils.approach(self.lerpProgress, 1, DT)
    local easeProg = Utils.ease(0, 1, self.lerpProgress, self.ease_type)
    self.cutout_top = MathUtils.lerp(self.cutout_top, self.topcut, easeProg)
    self.cutout_bottom = MathUtils.lerp(self.cutout_bottom, self.botcut, easeProg)
    self.cutout_left = MathUtils.lerp(self.cutout_left, self.leftcut, easeProg)
    self.cutout_right = MathUtils.lerp(self.cutout_right, self.rightcut, easeProg)
end

return PartialSprite