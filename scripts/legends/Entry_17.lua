-- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
-- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

---@param cutscene LegendCutscene
return function(cutscene)
    cutscene.text_positions = { ["left"] = { 120, 320 } }
    Game.legend.music:play("overworld/ZZAZZ_Music")
    cutscene:setSpeed(6 / 6 - .66)
    cutscene:text("epic test", "left")
end
