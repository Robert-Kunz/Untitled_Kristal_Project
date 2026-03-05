return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    Greatest_Battle = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Sushi-dieb looked at Fifty in disgust.\n* Fifty only had a smirk to show.")
        cutscene:text("* This will be our legendary battle, SD!", "Smirk", "Fifty")
        cutscene:text("* Get ready!", "Cool", "Fifty")
        cutscene:text("* Fucking hell...", "Annoyed", "SD")
    end,
    Fish_Battle = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Sushi-dieb looked at Fifty in disgust.\n* Fifty only had a smirk to show.")
        cutscene:text("* This will be our legendary battle, SD!", "Smirk", "Fifty")
        cutscene:text("* Get ready!", "Cool", "Fifty")
        cutscene:text("* Fishing hell...", "Annoyed", "SD")
        cutscene:text("* [wait:10]...huh?", "Confused", "SD")
        cutscene:text("* What, too scared to swear?", "Cool", "Fifty")
        cutscene:text("* No no, I...", "Confused", "SD")
        cutscene:text("* I'm just confused...", "Annoyed", "SD")
        cutscene:text("* Can you swear??", "Confused", "SD")
        cutscene:text("* Fish", "Cool", "Fifty")
        cutscene:text("* Oh what.", "Confused", "Fifty")
        cutscene:text("* Must be some censoring", "Tired", "SD")
        if cutscene:getCharacter("Honeywisp") then
            cutscene:text("* I-I'm sorry, what?", "confused", "Honeywisp")
            cutscene:text("* You wouldn't get it", "idle", "SD")
            cutscene:text("* Yeah that stupid Honeywisp \n* couldn't comprehend [color:yellow]the wall[color:reset]",
                "Annoyed", "Fifty")
            cutscene:text("* A-and you don't have to insult me, A-ass", "annoyed", "Honeywisp")
        end
    end,

    Parody = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* SD started to speak to Fifty")
        cutscene:text("* Fifty...[wait:5] Please... \n* just accept you are the parody", "Tired", "SD")
        cutscene:text("* BAHAHAHA, AS IF!", "Laughing", "Fifty")
        cutscene:text("* He'll never get it...", "Hopeless", "SD")
        cutscene:text("* Fifty is distracted!\n* He's unable to dodge this turn!")
    end,

    Tired = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Sushi-dieb looked at Fifty in disgust.\n* Fifty was just yawning.")
        cutscene:text("* heh... I'm so tired from this battle...", "Tired", "Fifty")
        cutscene:text("* But you wouldn't believe me!", "Annoyed", "Fifty")
        cutscene:text("* Isn't that right, Sushi-dieb?", "Smirk", "Fifty")
        cutscene:text("* Go to hell, Fifty", "Annoyed", "SD")
        Game.battle.encounter:addEnemy("Test")
        Game.battle.encounter:addEnemy("Test")
    end,
    Fish_Tired = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Sushi-dieb looked at Fifty in disgust.\n* Fifty was just yawning.")
        cutscene:text("* heh... I'm so tired from this battle...", "Tired", "Fifty")
        cutscene:text("* But you wouldn't believe me!", "Annoyed", "Fifty")
        cutscene:text("* Isn't that right, Sushi-dieb?", "Smirk", "Fifty")
        cutscene:text("* Go to Fish, Fifty", "Annoyed", "SD")
        cutscene:text("* I mean Fish", "idle", "SD")
        cutscene:text("* Oh come on, why the censors.", "Confused", "SD")
    end,

    Deletion = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* " + battler.chara:getName() + " cast Deletion!")
        cutscene:text("* [wait:10]...but!")
        cutscene:text("* BAHAHAHA, AS IF!", "Laughing", "Fifty")
        cutscene:text("* Trying to cheese ME?!", "Annoyed", "Fifty")
        cutscene:text("* I expected something more honorable of [color:red]you[color:reset].", "Annoyed", "Fifty")
    end,

    Honeywisp = function(cutscene, battler, enemy)
        cutscene:text("* Oh, looky here, a threat of organic life.", "Annoyed", "Fifty")
        cutscene:text("* All that Trauma hasn't beaten you down already?", "Annoyed", "Fifty")
        cutscene:text("* S-shut up...", "idle", "Honeywisp")
        cutscene:text("* You're just a waste of organic life,[wait:3] Honeywisp...", "Annoyed", "Fifty")
        cutscene:text("* And as the leader of Team Organic...", "Smirk", "Fifty")
        cutscene:text("* I will strike you down!", "Cool", "Fifty")
        cutscene:text("* Eeeek!", "Scared", "Honeywisp")
        cutscene:text("* I-I won't back down...\n* I w-will save winged...", "Scared", "Honeywisp")
        cutscene:text("* E-even if it means to beat you!", "Scared", "Honeywisp")
    end
}
