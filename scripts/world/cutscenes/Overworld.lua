return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    -- TO BE REMOVED
    Profanity_toggle = function(cutscene, battler, enemy)
        cutscene:text("* Profanity?", nil, "missingno")
        local choicer = cutscene:choicer({
            "Yeaaaaaaa",
            "noooooooo"
        })
        if choicer == 1 then
            cutscene:text("* Alright, Profanity is back on the menu, boys.", nil, "missingno")
            Game:setFlag("Profanity", true)
        elseif choicer == 2 then
            Game:setFlag("Profanity", false)
            cutscene:text("* You're boring, or professional.", nil, "missingno")
        end
    end,

    begin = function(cutscene, battler, enemy)
        if Game.save_name == "DEBUG" then
        elseif Game.save_name == "HW" then
            cutscene:fadeOut()
            cutscene:wait(2)
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
        else
            cutscene:fadeOut()
            cutscene:wait(2)
            cutscene:text("* [speed:0.4]YOU COULDN'T SAVE [color:green]THEM[color:reset]...", nil,
                "gaster", { auto = true, noskip = true })
            cutscene:text("* [speed:0.4]YOU LET [color:green]THEM[color:reset] DIE...", nil, "gaster",
                { auto = true, noskip = true })
            cutscene:text("* [speed:0.4]AND [color:yellow]WHAT[color:reset] FOR...?", nil, "gaster", { noskip = true })
            cutscene:text("* IT WAS [color:red]" + Game.save_name + "[color:reset], not me!", "Tired", "SD")
            cutscene:text("* [speed:0.4][color:red]" + Game.save_name + "[color:reset], YOU SAY...?", nil, "gaster")
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
                error("[color:red]YOU ARE NOT ALLOWED THIS NAME[color:reset]")
            else
                cutscene:text("* [speed:0.4]YOU REALLY ARE AS BAD AS THEY DESCRIBED...", nil, "gaster")
            end
            cutscene:text("* [speed:0.4]GOODBYE...", nil, "gaster")
            cutscene:text("* NO WAIT I STILL HAVE QUESTIONS", "idle", "SD")
            cutscene:text("* WAIT-!", "idle", "SD", { auto = true })
            cutscene:wait(1)
            cutscene:fadeIn()
            cutscene:wait(1)
            cutscene:text("* DAMMIT", "Annoyed", "SD")
        end
    end
}
