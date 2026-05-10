return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Barracuda_refight = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local x, y = cutscene:getMarker("camera_spot")
        local cuda = cutscene:getCharacter("Barracuda")
        cutscene:detachCamera()
        local SD = cutscene:getCharacter("SD")
        cutscene:detachFollowers()
        cutscene:panTo(x, y, 2)
        Game.world.camera:panTo(x, y, 2)
        if SD then
            cutscene:walkTo("SD", "place", 1)
        end
        if cutscene:getCharacter("Honeywisp") then
            cutscene:walkTo("Honeywisp", "placeH", 1)
        end
        cutscene:wait(1.2)
        if SD then
            SD:setFacing("right")
        end
        if cutscene:getCharacter("Honeywisp") then
            cutscene:getCharacter("Honeywisp"):setFacing("right")
        end
        cutscene:text("* ...", "idle", "Barracuda")
        cutscene:startEncounter("Barracuda", nil, cuda)
        cutscene:text("* lucky...", "annoyed", "Barracuda")
        cutscene:alignFollowers()
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,

    Fifty_refight = function(cutscene, battler, enemy)
        cutscene:text("* So you want to fight me?", "Smirk", "Fifty")
        local choicer = cutscene:choicer({
            "Hell yeah",
            "Fuck you",
            "Fish"
        })
        local Fifty = cutscene:getCharacter("FiftyN")
        if choicer == 1 then
            cutscene:text("* Bring it on!", "Happy", "Fifty")
            cutscene:text("* (Which Version?)")
            local choicerr = cutscene:choicer({
                "Great Challenge",
                "Birthday Bash"
            })
            if choicerr == 1 then
                cutscene:text("* Bring it ON!", "grin", "soul")
            end
            if choicerr == 2 then
                cutscene:text("* Birthday Bash! Yeah!", "smile", "soul")
                Game:setFlag("Birthday", true)
            end
            cutscene:startEncounter("Fifty", nil, Fifty)
            Game:setFlag("Birthday", false)
        elseif choicer == 2 then
            cutscene:text("* Then why speak to me...", "Annoyed", "Fifty")
        elseif choicer == 3 then
            cutscene:text("* You sure fucked it.", "Cool", "Fifty")
            cutscene:text("* OKAY FUCK YOU SHE ISN'T A PIECE OF SUSHI", "Annoyed", "SD")
            cutscene:text("* Huh???", "Scared", "Honeywisp")
        end
    end,
}
