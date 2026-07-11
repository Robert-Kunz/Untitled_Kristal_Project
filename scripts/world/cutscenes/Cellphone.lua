return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Profanity_toggle = function(cutscene, battler, enemy)
        cutscene:text("* Ya like profanity?", nil, nil)
        -- Sets up a choice between enabling and disabling profanity
        local choicer = cutscene:choicer({
            "Yeaaaaaaa",
            "noooooooo"
        })
        if choicer == 1 then
            cutscene:text("* Alright, Profanity is back on the menu, boys.", nil, nil)
            Game:setFlag("Profanity", true)
        elseif choicer == 2 then
            Game:setFlag("Profanity", false)
            cutscene:text("* You're boring, or professional.\n* No way to tell from this.", nil, nil)
        end
    end,
    Call = function(cutscene, battler, enemy)
        cutscene:text("* Who you're gonna call?", nil, nil)
        -- choice between 4 options
        local choicer = cutscene:choicer({
            "GHOST BUSTERS!",
            "Profanity toggle",
            "Tester",
            "Dark, yet Darker..."
        })
        if choicer == 1 then
            -- joke
            Assets.playSound("phone", 0.7)
            cutscene:wait(1)
            cutscene:text("* haha, really thought I would do that?", nil, nil)
        elseif choicer == 2 then
            -- starts profanity_toggle cutscene
            Assets.playSound("phone", 0.7)
            cutscene:wait(1)
            cutscene:gotoCutscene("Cellphone", "Profanity_toggle")
        elseif choicer == 3 then
            -- tbd
            Assets.playSound("phone", 0.7)
            cutscene:wait(1)
            cutscene:text("* Know a man's weakness, you [color:red][shake:1]own[shake:0][color:reset] their mind...", nil,
                "missingno")
            cutscene:text("* why [color:red][shake:1]resist[shake:0][color:reset]?\n* It's Hopeless regardless...", nil,
                "missingno")
        elseif choicer == 4 then
            Assets.playSound("phone", 0.7)
            cutscene:wait(1)
            if math.random(1, 2) == 1 then
                -- Binary says: "Dark Darker yet Darker. My name is [MISSINGNO.]"
                cutscene:text("* 01000100 01100001 01110010 01101011 00100000 01000100", nil, "missingno")
                cutscene:text("* 01100001 01110010 01101011 01100101 01110010 00100000", nil, "missingno")
                cutscene:text("* 01111001 01100101 01110100 00100000 01000100 01100001", nil, "missingno")
                cutscene:text("* 01110010 01101011 01100101 01110010 00101110 00001010", nil, "missingno")
                cutscene:text("* 01001101 01111001 00100000 01101110 01100001 01101101", nil, "missingno")
                cutscene:text("* 01100101 00100000 01101001 01110011 00100000 01011011", nil, "missingno")
                cutscene:text("* 01001101 01001001 01010011 01010011 01001001 01001110", nil, "missingno")
                cutscene:text("* 01000111 01001110 01001111 00101110 01011101", nil, "missingno")
            else
                cutscene:text("[speed:0.2][font:wingdings]ENTRY NUMBER 17", nil, "gaster")
                cutscene:text("[speed:0.2][font:wingdings]DARK, DARKER, YET DARKER", nil, "gaster")
                cutscene:text("[speed:0.2][font:wingdings]THE DARKNESS KEEPS GROWING DEEPER", nil, "gaster")
                cutscene:text("[speed:0.2][font:wingdings]THE DARKNESS CUTS THROUGH THE SHADOWS", nil, "gaster")
                cutscene:text("[speed:0.2][font:wingdings]THIS NEXT EXPERIMENT SEEMS VERY, VERY INTERESTING", nil,
                    "gaster")
                cutscene:text("[speed:0.2][font:wingdings]WHAT DO YOU TWO THINK?", nil, "gaster")
            end
            cutscene:wait(1)
            cutscene:text("* The line went dry...", nil, nil)
        end
    end
}
