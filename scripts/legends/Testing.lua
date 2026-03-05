---@param cutscene LegendCutscene
return function(cutscene)
    cutscene.text_positions = { ["left"] = { 120, 320 } }
    Game.legend.music:play("overworld/ZZAZZ_Music")
    cutscene:setSpeed(6 / 6 - .66)
    cutscene:text("epic test", "left")
end
