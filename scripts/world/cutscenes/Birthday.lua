return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Birthday_leave = function(cutscene, battler, enemy)
        cutscene:text("* Okay but honestly, why on my birthday?", "Annoyed", "SD")
        cutscene:text("* Thought it would be funny.", "Cool", "Fifty")
        cutscene:text("* ...", "Hopeless", "SD")
        cutscene:text("* Jesus fucking christ...", "Annoyed", "SD")
        cutscene:text("* Until we meet again!", "Happy", "Fifty")
    end,

    Birthday_enter = function(cutscene, battler, enemy)
        cutscene:alignFollowers("left", Game.world.player.x, Game.world.player.y, 50)
        local Fifty = cutscene:getCharacter("FiftyN")
        cutscene:text("* ...", "Hopeless", "SD")
        cutscene:text("* Are you fucking kidding me...", "Hopeless", "SD")
        cutscene:text("* BAHAHAHA", "Laughing", "Fifty")
        cutscene:text("* I have come to crash your Birthday, SD!", "Cool", "Fifty")
        cutscene:text("* Come on man, the one day I hope to have peace...", "Tired", "SD")
        cutscene:text("* Shut, I took some attacks especially for this.", "Annoyed", "Fifty")
        cutscene:text("* Don't ruin this.", "Annoyed", "Fifty")
        cutscene:text("* God... [wait:3]FINE", "Annoyed", "SD")
        cutscene:text("* I'll fight you... Just leave me alone after this.", "Hopeless", "SD")
        cutscene:text("* D-do I get a say in this...?", "Scared", "Honeywisp")
        cutscene:text("* ...[wait:5]no", "Hopeless", "SD")
        cutscene:startEncounter("Birthday_fight", nil, Fifty)
        cutscene:gotoCutscene("Birthday", "Birthday_leave")
    end,

    fight = function(cutscene, battler, enemy)
        cutscene:text("* So you want to fight me again?", "Smirk", "Fifty")
        local choicer = cutscene:choicer({
            "Hell yeah",
            "Fuck you",
            "Fish"
        })
        local Fifty = cutscene:getCharacter("FiftyN")
        if choicer == 1 then
            cutscene:text("* Bring it on!", "Happy", "Fifty")
            cutscene:startEncounter("Birthday_fight", nil, Fifty)
            cutscene:gotoCutscene("Birthday", "refight_end")
        elseif choicer == 2 then
            cutscene:text("* Then why speak to me...", "Annoyed", "Fifty")
        elseif choicer == 3 then
            cutscene:text("* You sure fucked it.", "Cool", "Fifty")
            cutscene:text("* OKAY FUCK YOU SHE ISN'T A PIECE OF SUSHI", "Annoyed", "SD")
            cutscene:text("* Huh???", "Scared", "Honeywisp")
        end
    end,

    refight_end = function(cutscene, battler, enemy)
        cutscene:text("* You got lucky this time...", "Annoyed", "Fifty")
    end
}
