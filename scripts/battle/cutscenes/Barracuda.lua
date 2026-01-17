return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    low_health = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local enemies = Game.battle.enemies
        cutscene:text("* You make a stance infront of Barracuda")
        cutscene:text("* Look, Barracuda, whatever you're trying to do\n* it won't work", "Annoyed", "SD")
        cutscene:text("* We both know how this will end...", "Tired", "SD")
        cutscene:text("* So why don't you just stop?", "Annoyed", "SD")
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:text("* YOU TELL LIES, KID", "angry", "Barracuda")
        cutscene:text("* Listen here...", "Annoyed", "SD")
        cutscene:text("* NO, YOU LISTEN TO ME", "angry", "Barracuda")
        cutscene:text("* THIS AIN'T A RAP BATTLE, KID.\n* AND IT ISN'T THERAPY AS WELL.", "idle", "Barracuda")
        cutscene:text("* I WILL NOT DISAPPOINT BOSS AGAIN.", "angry", "Barracuda")
        cutscene:text("* SO YOU TAKE YOUR EXCUSES...", "angry", "Barracuda")
        for _, v in pairs(enemies) do -- this is a for loop
            if v.id == "Barracuda" then
                v:setAnimation("awakening")
            end
        end
        cutscene:wait(3.5)
        cutscene:text("* AND LEAVE!", "awakened", "Barracuda")
    end,
    Convince = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* You make a stance infront of Barracuda")
        cutscene:text("* Look, Barracuda, whatever you're trying to do\n* it won't work", "idle", "SD")
        cutscene:text("* We both know how this will end...", "Tired", "SD")
        cutscene:text("* So why don't you just stop?", "idle", "SD")
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:text("* YOU TELL LIES, KID", "angry", "Barracuda")
        cutscene:text("* Listen here...", "Annoyed", "SD")
        cutscene:text("* NO, YOU LISTEN TO ME", "angry", "Barracuda")
        cutscene:text("* THIS AIN'T A RAP BATTLE, KID.\n* AND IT ISN'T THERAPY AS WELL", "idle", "Barracuda")
        cutscene:text("* I WILL NOT DISAPPOINT BOSS AGAIN.", "angry", "Barracuda")
        cutscene:text("* SO YOU TAKE YOUR EXCUSES...", "angry", "Barracuda")
        enemy:setAnimation("awakening")
        cutscene:wait(3.5)
        cutscene:text("* AND LEAVE!", "awakened", "Barracuda")
    end
}
