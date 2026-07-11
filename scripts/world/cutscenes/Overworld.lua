return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    placeholder = function(cutscene, battler, enemy)
        cutscene:text(
            "* This [color:yellow]missing content[color:reset] is [color:yellow]Pissing[color:reset] me off...")
        cutscene:text("* I'm the original   [color:yellow]Starwalker[color:reset]")
    end,

    begin = function(cutscene, battler, enemy)
        local SD = cutscene:getCharacter("SD")
        if Game.save_name == "DEBUG" then
        elseif Game.save_name == "RANDOM" or Game.save_name == "EGGY" or Game.save_name == "FIFTYSET80" or Game.save_name == "PEACHY" or Game.save_name == "MACC" or Game.save_name == "MACCPRO" or Game.save_name == "MINTYMORON" or Game.save_name == "SEMANTICS" then
            cutscene:fadeOut()
            cutscene:wait(2)
            cutscene:text("* ...")
            cutscene:text("* Hi! Dev here!")
            cutscene:text("* I would assume you either read the README (good job :D)\nor are one of my friends...")
            cutscene:text("* Yeah so like, hope you enjoy it :D")
            cutscene:text("* I'm gonna let mystery man talk now, kay?")
            cutscene:wait(2)
            cutscene:text("* [speed:0.3]Very[wait:1] Very[wait:1] Interesting...", nil, "gaster")
            cutscene:text(
                "* [speed:0.3]You seem to want [color:yellow]them[color:reset]\nto recognize you, [color:red]" ..
                Game.save_name ..
                "[color:reset]...",
                nil, "gaster")
            cutscene:text("* [speed:0.3]Very well...", nil, "gaster")
            cutscene:wait(1)
            cutscene:fadeIn()
            cutscene:wait(1)
            cutscene:text("* Oh... it's you, " .. Game.save_name .. ".\n* Very well... just don't mess shit up.", "idle",
                "SD")
            if Game.save_name == "RANDOM" then
                cutscene:text("* Oh and " .. Game.save_name .. ", don't torture [color:pink]her[color:reset], kay?",
                    "Tired", "SD")
            end
            Game:setFlag("Friend_name", true)
        elseif Game.save_name == "HW" or Game.save_name == "HONEYWISP" or Game.save_name == "SD" then
            Game:setFlag("Solo_run", true)
            cutscene:fadeOut()
            cutscene:wait(2)
            if Game.save_name == "HW" or Game.save_name == "HONEYWISP" then
                Game:setPartyMembers("Honeywisp")
                Game.world:spawnFollower("Honeywisp", { 2, "Honeywisp", false, SD.x, SD.y })
                local HW = cutscene:getCharacter("Honeywisp")
                HW:convertToPlayer()
                Game:getPartyMember("Honeywisp"):setArmor(2, "PS")
                SD:remove()
                Game:setFlag("HW_solo", true)
            elseif Game.save_name == "SD" then
                Game:setFlag("SD_solo", true)
                Game:setPartyMembers("SD")
                Game:getPartyMember("SD"):setArmor(2, "PS")
            else
                Game:setPartyMembers("Fifty")
            end
            cutscene:text(
                "* [color:red]THIS IS NOT INTENDED TO BE YOUR FIRST PLAYTHROUGH, PLEASE PLAY THROUGH THE MAIN STORY FIRST!")
            cutscene:text(
                "* Do you want Temp Party Members?\n* ([color:yellow]NOTE: YOU CANNOT CHANGE YOUR SELECTION![color:reset])",
                nil, nil)
            local choicer = cutscene:choicer({
                "Yes",
                "No"
            })
            if choicer == 1 then
                cutscene:text("* Yay, my Time wasn't wasted on them!", nil, nil)
                Game:setFlag("Temp_Party", true)
            elseif choicer == 2 then
                Game:setFlag("Temp_Party", false)
                cutscene:text("* That's fine, it'll just be harder!", nil, nil)
            end
            cutscene:text("* Now I'll let mystery man talk", nil, nil)
            cutscene:wait(2)
            cutscene:text("* [speed:0.3]Very[wait:1] Very[wait:1] Interesting...", nil, "gaster")
            cutscene:text("* [speed:0.3]You seem to[wait:1] want to challenge yourself...", nil, "gaster")
            cutscene:text("* [speed:0.3]...", nil, "gaster")
            cutscene:text("* [speed:0.3]Very well...", nil, "gaster")
            cutscene:text("* [speed:0.3]The [color:red]Story[color:reset][wait:1] will be altered...", nil, "gaster")
            cutscene:text(
                "* [speed:0.3]Say 'Hello' to T[color:pink]H[color:red]E[color:black]M[color:reset][wait:1], for me.",
                nil,
                "gaster")
            cutscene:wait(1)
            cutscene:fadeIn()
            cutscene:wait(1)
            if Game:getFlag("HW_solo", false) then
                cutscene:text("* ...", "idle", "Honeywisp")
                cutscene:text("* Where the hell am I???", "confused", "Honeywisp")
                cutscene:text("* And... what[wait:3] is[wait:3] this[wait:3] Armor?!", "confused", "Honeywisp")
                cutscene:text("* ...", "thinking", "Honeywisp")
                cutscene:text("* W-well... this certainly isn't my home...", "idle", "Honeywisp")
            elseif Game:getFlag("SD_solo", false) then
                cutscene:text("* ...", "idle", "SD")
                cutscene:text("* What, THE HELL, did you do.", "Annoyed", "SD")
                cutscene:text("* ...", "Annoyed", "SD")
                cutscene:text("* No response?", "Annoyed", "SD")
                cutscene:wait(1)
                cutscene:text("* Alright, fine... Just know this shit will be harder.", "Hopeless", "SD")
            end
        else
            cutscene:fadeOut()
            cutscene:wait(2)
            cutscene:text("* [speed:0.4]YOU COULDN'T SAVE [color:green]THEM[color:reset]...", nil,
                "gaster", { auto = true, noskip = true })
            cutscene:text("* [speed:0.4]YOU LET [color:green]THEM[color:reset] DIE...", nil, "gaster",
                { auto = true, noskip = true })
            cutscene:text("* [speed:0.4]AND [color:yellow]WHAT[color:reset] FOR...?", nil, "gaster", { noskip = true })
            cutscene:text("* IT WAS [color:red]" .. Game.save_name .. "[color:reset], not me!", "Tired", "SD")
            cutscene:text("* [speed:0.4][color:red]" .. Game.save_name .. "[color:reset], YOU SAY...?", nil, "gaster")
            cutscene:text("* [speed:0.4]...", nil, "gaster")
            if Game.save_name == "ROBERT" then
                cutscene:text("* [speed:0.4]THAT'S...[wait:1] THE [color:red]DEVELOPER[color:reset]'S NAME...", nil,
                    "gaster")
                cutscene:text("* Way to break the 4th wall, Gaster", "Annoyed", "SD")
                cutscene:text("* ...", nil, "gaster")
                cutscene:text("* YOU REALLY ARE AS BAD AS THEY DESCRIBED...", nil, "gaster")
            elseif Game.save_name == "SD" then
                Game.inventory:addItemTo("storage", "Cake")
                Game.inventory:addItemTo("storage", "Cake")
                cutscene:text("* [speed:0.4]THAT'S...[wait:1] [shake:1][color:red]YOU[color:reset]", nil, "gaster")
                cutscene:text("* [speed:0.4]YOU REALLY ARE AS BAD AS THEY DESCRIBED...", nil, "gaster")
            elseif Game.save_name == "HONEYWISP" or Game.save_name == "HW" then
                Game.inventory:addItemTo("storage", "F_Jello")
                Game.inventory:addItemTo("storage", "F_Jello")
                Game.inventory:addItemTo("storage", "F_Jello")
                Game.inventory:addItemTo("storage", "F_Jello")
                cutscene:text("* [speed:0.4]...[shake:1][color:pink]HER[color:reset]?", nil, "gaster")
                cutscene:text("* [speed:0.4]DON'T BE RIDICULOUS.", nil, "gaster")
                cutscene:text("* B-but I'm telling the truth! It's [color:red]their[color:reset] name...", "Hopeless",
                    "SD")
            elseif Game.save_name == "50" or Game.save_name == "FIFTYSET80" or Game.save_name == "50SET80" then
                Game:setFlag("Birthday", true)
                cutscene:text("* [speed:0.4][color:black]50[color:reset] CAN'T CONTROL YOU...", nil, "gaster")
                cutscene:text("* [speed:0.4]DON'T BE RIDICULOUS.", nil, "gaster")
                cutscene:text("* B-but I'm telling the truth! It's [color:red]their[color:reset] name...", "Hopeless",
                    "SD")
            elseif Game.save_name == "GASTER" or Game.save_name == "WDGASTER" then
                cutscene:text("* [shake:1][speed:0.1]...", nil, "gaster")
                cutscene:text(
                    "* [shake:3][speed:2][font:wingdings]DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER DARK DARKER YET DARKER",
                    nil, "gaster", { auto = true, noskip = true })
                error("YOU ARE NOT ALLOWED THIS NAME")
            else
                cutscene:text("* [speed:0.4]YOU REALLY ARE AS BAD AS THEY DESCRIBED...", nil, "gaster")
            end
            cutscene:text("* [speed:0.4]GOODBYE...", nil, "gaster")
            cutscene:text("* NO WAIT I STILL HAVE QUESTIONS", "idle", "SD", { auto = true })
            cutscene:text("* WAIT-!", "idle", "SD", { auto = true })
            cutscene:wait(1)
            cutscene:fadeIn()
            cutscene:wait(1)
            cutscene:text("* DAMMIT", "Annoyed", "SD")
            local x, y = SD.x + 50, SD.y - 50
            local soul = Sprite("player/heart_dodge", x, y)
            cutscene:wait(1)


            -- Assets.playSound("greatshine")
            cutscene:wait(1)
            soul:setOrigin(0.5, 0.5)
            soul:setColor(1, 0, 0)
            Game.stage:addChild(soul)
            soul:addChild(FlashFade("player/heart_dodge", 0, 0))
            cutscene:wait(1)
            cutscene:getCharacter("SD"):setFacing("right")
            cutscene:text("* Okay, look-", "annoyed", "soul", { auto = true })
            cutscene:text("* Just...", "Hopeless", "SD", { auto = true })
            cutscene:wait(0.3)
            cutscene:text("* Just... shut it, " .. Game.save_name, "Hopeless", "SD")
            cutscene:text("* Hear me out, okay?", "idle", "soul")
            cutscene:text("* NO!", "Annoyed", "SD")
            cutscene:text("* [REDACTED] just screwed me over and now you're here??", "Annoyed", "SD")
            cutscene:text("* What the hell else could go wrong today?", "Annoyed", "SD")
            cutscene:text("* Jeez, calm down, I wasn't gonna do anything [color:yellow]weird[color:reset] this time...",
                "annoyed", "soul")
            cutscene:text("* Go vanish again, I need a few seconds alone...", "Hopeless", "SD")
            cutscene:text("* You're no fun...", "annoyed", "soul")
            soul:fadeOutAndRemove(2)
            Assets.playSound("mysterygo")
        end
    end,

    portal_to_JSAB = function(cutscene, battler, enemy)
        local SD = cutscene:getCharacter("SD")
        local HW = cutscene:getCharacter("Honeywisp")
        cutscene:text("* The Portal seems to call out to you...")
        if SD then
            cutscene:text("* What is a rift doing here?", "Confused", "SD")
        end
        if HW then
            cutscene:text("* I-I don't know if this is...", "idle", "Honeywisp")
        end
        cutscene:text("* Do you enter it?")
        local choicer = cutscene:choicer({
            "Yes",
            "No"
        })
        if choicer == 1 then
            if SD then
                cutscene:text("* Eh, who cares, I don't have a choice in this anyways...", "idle", "SD")
            end
            if HW then
                cutscene:text("* ...", "idle", "Honeywisp")
            end
            cutscene:text("* You enter the Portal.")
            cutscene:fadeOut()
            cutscene:wait(1)
            cutscene:text("* ...")
            -- Map transition
            cutscene:mapTransition("JSAB_preview1", "portal_spawn")
            if SD then
                SD:setFacing("down")
            end
            if HW then
                HW:setFacing("down")
            end
            cutscene:wait(1)
            cutscene:fadeIn()
            if Game:getFlag("First_portal", true) then
                cutscene:wait(1)
                Game:setFlag("First_portal", false)
                cutscene:text("* [color:red]WARNING: Everything after this point is subject to change.")
                cutscene:gotoCutscene("Overworld", "Great_Challenge_HW_intro")
            end
        elseif choicer == 2 then
            if SD then
                cutscene:text("* Yeah no way.", "idle", "SD")
            end
            if HW then
                cutscene:text("* C-could be another rift in the 4th wall...", "idle", "Honeywisp")
            end
            cutscene:text("* You decide it's too risky.")
        end
    end,

    portal_to_unknown = function(cutscene, battler, enemy)
        local SD = cutscene:getCharacter("SD")
        local HW = cutscene:getCharacter("Honeywisp")
        cutscene:text("* The Portal seems to call out to you...")
        if SD then
            cutscene:text("* What is a rift doing here?", "Confused", "SD")
        end
        if HW then
            cutscene:text("* I-I don't know if this is...", "idle", "Honeywisp")
        end
        cutscene:text("* Do you enter it?\n* ([color:yellow]You won't be able to return...[color:reset])")
        local choicer = cutscene:choicer({
            "Yes",
            "No"
        })
        if choicer == 1 then
            if SD then
                cutscene:text("* Eh, who cares, I don't have a choice in this anyways...", "idle", "SD")
            end
            if HW then
                cutscene:text("* ...", "idle", "Honeywisp")
            end
            cutscene:text("* You enter the Portal.")
            cutscene:fadeOut()
            cutscene:wait(1)
            cutscene:text("* ...")
            -- Map transition
            cutscene:mapTransition("enemy_select", "portal_spawn")
            if SD then
                SD:setFacing("down")
            end
            if HW then
                HW:setFacing("down")
            end
            cutscene:wait(1)
            cutscene:fadeIn()
            cutscene:text("* Welp, this is uh, the last room, for this build!")
            cutscene:text("* Have fun with the Enemies and such, I guess?")
            cutscene:text("* Feel free to change your Party or toggle the Dodgesoul using Starwalker.")
            cutscene:text("* And if possible, provide feedback! You should have my Discord...")
            cutscene:text("* ...")
            cutscene:text("* Oh yeah, also, if you want to spice up this first part...")
            cutscene:text(
                "* Use the name '[color:black]SD[color:reset]', '[color:pink]HW[color:reset]' or '[color:pink]Honeywisp[color:reset]'.")
            cutscene:text("* More explanation as to what those bring in the README...")
            cutscene:text("* Or by just, starting a game with those names.")
            cutscene:text("* Enough from me, have fun with this!")
        elseif choicer == 2 then
            if SD then
                cutscene:text("* Yeah no way.", "idle", "SD")
            end
            if HW then
                cutscene:text("* C-could be another rift in the 4th wall...", "idle", "Honeywisp")
            end
            cutscene:text("* You decide it's too risky.")
        end
    end,

    portal_to_pik = function(cutscene, battler, enemy)
        local SD = cutscene:getCharacter("SD")
        local HW = cutscene:getCharacter("Honeywisp")
        cutscene:text("* The Portal seems to call out to you...")
        if SD then
            cutscene:text("* What is a rift doing here?", "Confused", "SD")
        end
        if HW then
            cutscene:text("* I-I don't know if this is...", "idle", "Honeywisp")
        end
        cutscene:text("* Do you enter it?")
        local choicer = cutscene:choicer({
            "Yes",
            "No"
        })
        if choicer == 1 then
            if SD then
                cutscene:text("* Eh, who cares, I don't have a choice in this anyways...", "idle", "SD")
            end
            if HW then
                cutscene:text("* ...", "idle", "Honeywisp")
            end
            cutscene:text("* You enter the Portal.")
            cutscene:fadeOut()
            cutscene:wait(1)
            cutscene:text("* ...")
            -- Map transition
            cutscene:mapTransition("tutorial_area5", "portal_spawn")
            if SD then
                SD:setFacing("down")
            end
            if HW then
                HW:setFacing("down")
            end
            cutscene:wait(1)
            cutscene:fadeIn()
        elseif choicer == 2 then
            if SD then
                cutscene:text("* Yeah no way.", "idle", "SD")
            end
            if HW then
                cutscene:text("* C-could be another rift in the 4th wall...", "idle", "Honeywisp")
            end
            cutscene:text("* You decide it's too risky.")
        end
    end,

    Great_Challenge_HW_intro = function(cutscene, battler, enemy)
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                cutscene:text("* Right,[wait:3] Solo run,[wait:3] no Honeywisp to aid me...", "idle", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* This place again...", "idle", "Honeywisp")
                cutscene:text("* ...", "look_down", "Honeywisp")
                cutscene:text("* I-I guess I'll go on...", "idle", "Honeywisp")
            end
        else
            local SD = cutscene:getCharacter("SD")
            local x, y = cutscene:getMarker("HW_spawn")
            Game:addPartyMember("Honeywisp")
            Game.world:spawnFollower("Honeywisp", { 2, "Honeywisp", false, 1, 1 })
            local HW = cutscene:getCharacter("Honeywisp")
            cutscene:detachFollowers()
            HW.x = x
            HW.y = y
            cutscene:wait(cutscene:setAnimation(HW, { "battle/reappear", 1 / 12, false }))
            cutscene:setAnimation(HW, { "walk", 1 / 12, false })
            HW:setFacing("right")
            SD:setFacing("left")
            cutscene:text("* ...", "idle", "Honeywisp")
            cutscene:text("* Okay guess we ain't explaining this this time...", "idle", "SD")
            Assets.playSound("moss_fanfare")
            cutscene:text("* Honeywisp joins your party!")
            if Game:getFlag("Friend_name", false) then
                cutscene:wait(1)
                SD:setFacing("down")
                cutscene:text("* Oh, and " .. Game.save_name .. "?", "idle", "SD")
                cutscene:text("* Don't even attempt to try something...", "idle", "SD")
            end
            cutscene:wait(cutscene:attachFollowers())
            HW:setFacing("down")
        end
    end
}
