return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Leave = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Until we meet again, Sushi-dieb!", "Smirk", "Fifty")
        cutscene:text("* Damn that bastard", "Annoyed", "SD")
        cutscene:wait(2.5)
        cutscene:text("* Thanks for playing!", "Happy", "SD")
        cutscene:text("* This uh... was the last enemy", "Tired", "SD")
    end
}
