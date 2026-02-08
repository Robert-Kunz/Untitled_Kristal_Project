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
        cutscene:fadeOut()
        cutscene:wait(2)
        cutscene:text("* [speed:0.4]YOU COULDN'T SAVE [color:green]THEM[color:reset]...", nil,
            "gaster", { auto = true })
        cutscene:text("* [speed:0.4]YOU LET [color:green]THEM[color:reset] DIE...", nil, "gaster", { auto = true })
        cutscene:text("* [speed:0.4]AND [color:yellow]WHAT[color:reset] FOR...?", nil, "gaster")
        cutscene:text("* IT WAS [color:red]" + Game.save_name + "[color:reset], not me!", "Tired", "SD")
        cutscene:text("* [speed:0.4][color:red]" + Game.save_name + "[color:reset], YOU SAY...?", nil, "gaster")
        cutscene:text("* [speed:0.4]...", nil, "gaster")
        if Game.save_name == "SD" then
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
            cutscene:text("* B-but I'm telling the truth! It's [color:red]their[color:reset] name...", "Hopeless", "SD")
        elseif Game.save_name == "50" or Game.save_name == "FIFTYSET80" or Game.save_name == "50SET80" then
            Game:setFlag("Birthday", true)
            cutscene:text("* [speed:0.4][color:black]50[color:reset] CAN'T CONTROL YOU...", nil, "gaster")
            cutscene:text("* [speed:0.4]DON'T BE RIDICULOUS.", nil, "gaster")
            cutscene:text("* B-but I'm telling the truth! It's [color:red]their[color:reset] name...", "Hopeless", "SD")
        elseif Game.save_name == "GASTER" or Game.save_name == "WDGASTER" then
            cutscene:text("* [shake:1][speed:0.1]...", nil, "gaster")
            cutscene:text(
                "* [shake:3][speed:2]01000100 01000001 01010010 01001011 00100000 01000100 01000001 01010010 01001011 01000101 01010010 00100000 01011001 01000101 01010100 00100000 01000100 01000001 01010010 01001011 01000101 01010010 01000100 01000001 01010010 01001011 00100000 01000100 01000001 01010010 01001011 01000101 01010010 00100000 01011001 01000101 01010100 00100000 01000100 01000001 01010010 01001011 01000101 01010010 01000100 01000001 01010010 01001011 00100000 01000100 01000001 01010010 01001011 01000101 01010010 00100000 01011001 01000101 01010100 00100000 01000100 01000001 01010010 01001011 01000101 01010010 01000100 01000001 01010010 01001011 00100000 01000100 01000001 01010010 01001011 01000101 01010010 00100000 01011001 01000101 01010100 00100000 01000100 01000001 01010010 01001011 01000101 01010010 01000100 01000001 01010010 01001011 00100000 01000100 01000001 01010010 01001011 01000101 01010010 00100000 01011001 01000101 01010100 00100000 01000100 01000001 01010010 01001011 01000101 01010010",
                nil, "gaster", { auto = true })
            error("YOU ARE NOT ALLOWED THIS NAME")
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
}
