return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Barracuda_refight = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local x, y = cutscene:getMarker("camera_spot_A")
        local cuda = cutscene:getCharacter("Barracuda")
        cutscene:detachCamera()
        local SD = cutscene:getCharacter("SD")
        local Susie = cutscene:getCharacter("susie")
        cutscene:detachFollowers()
        cutscene:panTo(x, y, 2)
        Game.world.camera:panTo(x, y, 2)
        if SD then
            cutscene:walkTo("SD", "place_A", 1)
        end
        if cutscene:getCharacter("Honeywisp") then
            cutscene:walkTo("Honeywisp", "placeH_A", 1)
        end
        if Susie then
            cutscene:walkTo("susie", "placeS_A", 1)
        end
        cutscene:wait(1.2)
        if SD then
            SD:setFacing("right")
        end
        if cutscene:getCharacter("Honeywisp") then
            cutscene:getCharacter("Honeywisp"):setFacing("right")
        end
        if Susie then
            Susie:setFacing("right")
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
            if Game:getFlag("Solo_run", false) then
                if Game:getFlag("SD_solo", false) then
                    cutscene:text("* You sure fucked it.", "Cool", "Fifty")
                    cutscene:text("* OKAY FUCK YOU SHE ISN'T A PIECE OF SUSHI", "Annoyed", "SD")
                elseif Game:getFlag("HW_solo", false) then
                    cutscene:text("* You're not him...", "Annoyed", "Fifty")
                    cutscene:text("* Huh??", "confused", "Honeywisp")
                end
            else
                cutscene:text("* You sure fucked it.", "Cool", "Fifty")
                cutscene:text("* OKAY FUCK YOU SHE ISN'T A PIECE OF SUSHI!", "Annoyed", "SD")
                cutscene:text("* Huh???", "Scared", "Honeywisp")
            end
        end
    end,

    Great_Challenge = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local x, y = cutscene:getMarker("camera_spot")
        local cuda = cutscene:getCharacter("Barracuda", 2)
        local Fifty = cutscene:getCharacter("FiftyN", 2)
        local Sushi = cutscene:getCharacter("Test")
        cutscene:detachCamera()
        local SD = cutscene:getCharacter("SD")
        local HW = cutscene:getCharacter("Honeywisp")
        local Susie = cutscene:getCharacter("susie")
        cutscene:detachFollowers()
        cutscene:panTo(x, y, 2)
        Game.world.camera:panTo(x, y, 2)
        if SD then
            cutscene:walkTo("SD", "place", 2)
        end
        if HW then
            cutscene:walkTo("Honeywisp", "placeH", 2)
        end
        if Susie then
            cutscene:walkTo("susie", "placeS", 2)
        end
        cutscene:wait(2.2)
        if SD then
            SD:setFacing("right")
        end
        if HW then
            HW:setFacing("right")
        end
        if Susie then
            Susie:setFacing("right")
        end
        cutscene:text("* THIS,[wait:0.6] IS YOUR END!", "idle", "Barracuda")
        cutscene:text("* Oh yeah bring it on!", "Cool", "Fifty")
        cutscene:text("* ...", "idle", "Test")
        cutscene:startEncounter("Great_Challenge", nil, { cuda, Fifty, Sushi })
        cutscene:text("* lucky...", "annoyed", "Barracuda")
        cutscene:text("* Triangle, what the hell was that?!", "Annoyed", "Fifty")
        cutscene:text("* OH DON'T GET ME STARTED ON [color:red]YOU[color:reset],[wait:0.6] MUSHROOM HEAD", "angry",
            "Barracuda")
        cutscene:fadeOut()
        cutscene:wait(1.5)
        cutscene:attachCamera()
        local x, y = cutscene:getMarker("back")
        if SD then
            SD:setPosition(x, y)
        end
        if HW then
            HW:setPosition(x, y)
        end
        if Susie then
            Susie:setPosition(x, y)
        end
        if SD then
            SD:setFacing("down")
        end
        if HW then
            HW:setFacing("down")
        end
        if Susie then
            Susie:setFacing("down")
        end
        cutscene:text("* (You leave them to argue about their defeat to themselves...)")
        cutscene:alignFollowers()
        cutscene:attachFollowers()
        cutscene:wait(1)
        cutscene:fadeIn()
        cutscene:wait(1.5)
    end,

    Choice = function(cutscene, battler, enemy)
        local choicer = cutscene:textChoicer("* Are you ready to face [color:yellow]the Great Challenge[color:reset]?\n",
            { "Yes", "No" })
        if choicer == 1 then
            cutscene:gotoCutscene("ES", "Great_Challenge")
        else
            local SD = cutscene:getCharacter("SD")
            local HW = cutscene:getCharacter("Honeywisp")
            local Susie = cutscene:getCharacter("susie")
            cutscene:detachFollowers()
            if SD then
                cutscene:walkTo("SD", "back", 1)
            end
            if HW then
                cutscene:walkTo("Honeywisp", "back", 1)
            end
            if Susie then
                cutscene:walkTo("susie", "back", 1)
            end
            cutscene:wait(1.2)
            cutscene:alignFollowers()
            cutscene:wait(cutscene:attachFollowers())
        end
    end,

    funny = function(cutscene, battler, enemy)
        cutscene:text("* Yeah, this will be our great challenge!", "Cool", "Fifty")
        cutscene:text("* Say that, again.", "idle", "SD")
    end,

    party_change = function(cutscene, battler, enemy)
        cutscene:text(
            "* This [color:yellow]Party[color:reset] is [color:yellow]Pissing[color:reset] me off...")
        local choicer = cutscene:choicer({
            "SD Solo",
            "HW Solo",
            "SD and HW",
            "SD, HW, Susie (recommended)"
        })
        cutscene:fadeOut()
        cutscene:wait(2)
        local SD = cutscene:getCharacter("SD")
        local HW = cutscene:getCharacter("Honeywisp")
        local Susie = cutscene:getCharacter("susie")
        Game:setPartyMembers("Kris")
        if SD then
            Game.world:spawnFollower("kris", { 2, "kris", false, SD.x, SD.y })
        elseif HW then
            Game.world:spawnFollower("kris", { 2, "kris", false, HW.x, HW.y })
        end
        local kris = cutscene:getCharacter("kris")
        kris:convertToPlayer()
        if SD then
            SD:remove()
        end
        if HW then
            HW:remove()
        end
        if Susie then
            Susie:remove()
        end
        if choicer == 1 then
            Game:setFlag("Solo_run", true)
            Game:setFlag("SD_solo", true)
            Game:setFlag("HW_solo", false)
            Game:setPartyMembers("SD")
            Game.world:spawnFollower("SD", { 2, "SD", false, kris.x, kris.y })
            local SD = cutscene:getCharacter("SD")
            SD:convertToPlayer()
        elseif choicer == 2 then
            Game:setFlag("Solo_run", true)
            Game:setFlag("HW_solo", true)
            Game:setFlag("SD_solo", false)
            Game:setPartyMembers("Honeywisp")
            Game.world:spawnFollower("Honeywisp", { 2, "Honeywisp", false, kris.x, kris.y - 20 })
            local HW = cutscene:getCharacter("Honeywisp")
            HW:convertToPlayer()
        elseif choicer == 3 then
            Game:setFlag("Solo_run", false)
            Game:setFlag("SD_solo", false)
            Game:setFlag("HW_solo", false)
            Game:setPartyMembers("SD", "Honeywisp")
            Game.world:spawnFollower("SD", { 2, "SD", false, kris.x, kris.y })
            Game.world:spawnFollower("Honeywisp", { 2, "Honeywisp", false, kris.x, kris.y + 30 })
            local SD = cutscene:getCharacter("SD")
            SD:convertToPlayer()
        elseif choicer == 4 then
            Game:setFlag("Solo_run", false)
            Game:setFlag("SD_solo", false)
            Game:setFlag("HW_solo", false)
            Game:setPartyMembers("SD", "Honeywisp", "susie")
            Game.world:spawnFollower("SD", { 2, "SD", false, kris.x, kris.y })
            Game.world:spawnFollower("Honeywisp", { 2, "Honeywisp", false, kris.x, kris.y + 30 })
            Game.world:spawnFollower("susie", { 2, "susie", false, kris.x, kris.y + 60 })
            local SD = cutscene:getCharacter("SD")
            SD:convertToPlayer()
        end
        kris:remove()
        cutscene:fadeIn()
        cutscene:wait(1)
        cutscene:text("* I'm the original   [color:yellow]Starwalker[color:reset]")
    end,
    soul_change = function(cutscene, battler, enemy)
        cutscene:text(
            "* This [color:#fca600]Soul[color:reset] is [color:#fca600]Pissing[color:reset] me off...")
        local choicer = cutscene:choicer({
            "Dodge Soul",
            "Base Soul",
        })
        if choicer == 1 then
            Game:setFlag("DashSoul", true)
        elseif choicer == 2 then
            Game:setFlag("DashSoul", false)
        end
        cutscene:text("* I'm the orange   [color:#fca600]Starwalker[color:reset]")
    end
}
