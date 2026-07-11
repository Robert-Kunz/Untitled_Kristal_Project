return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    weapon_get = function(cutscene, battler, enemy)
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                local SD = cutscene:getCharacter("SD")
                cutscene:text("* ...huh?", "Confused", "SD")
                if SD then
                    cutscene:walkTo("SD", "place", 1)
                end
                cutscene:wait(1.2)
                if SD then
                    SD:setFacing("down")
                end
                cutscene:text("* [speed:0.7]What is that...?", "Confused", "SD")
                cutscene:text("* (SD picked up the [color:yellow]Vine[color:reset])")
                cutscene:text("* A...[wait:1] Vine?", "Confused", "SD")
                cutscene:text("* Well...", "idle", "SD")
                local r1, r2 = Game.inventory:tryGiveItem("basic_vine")
                Kristal.Console:log(r2)
                cutscene:text("* Could be useful?", "Confused", "SD")
                cutscene:text("* As a [color:red]weapon[color:reset]?", "Confused", "SD")
                cutscene:text(r2)
                cutscene:wait(1)
                cutscene:text("* (Why was it just... there?)", "Confused", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* ...huh?", "confused", "Honeywisp")
                if cutscene:getCharacter("Honeywisp") then
                    cutscene:walkTo("Honeywisp", "place", 1)
                end
                cutscene:wait(1.2)
                if cutscene:getCharacter("Honeywisp") then
                    cutscene:getCharacter("Honeywisp"):setFacing("down")
                end
                cutscene:text("* [speed:0.7]What is that...?", "confused", "Honeywisp")
                cutscene:text("* (Honeywisp picked up the [color:yellow]Vine[color:reset])")
                cutscene:text("* A...[wait:1] Vine?", "confused", "Honeywisp")
                cutscene:text("* I-I guess?", "idle", "Honeywisp")
                local r1, r2 = Game.inventory:tryGiveItem("basic_vine")
                Kristal.Console:log(r2)
                cutscene:text("* ...", "look_down", "Honeywisp")
                cutscene:text("* What do I do with it though...", "thinking", "Honeywisp")
                cutscene:text(r2)
            end
        else
            local SD = cutscene:getCharacter("SD")
            cutscene:detachFollowers()
            cutscene:text("* ...huh?", "Confused", "SD")
            if SD then
                cutscene:walkTo("SD", "place", 1)
            end
            if cutscene:getCharacter("Honeywisp") then
                cutscene:walkTo("Honeywisp", "placeH", 1)
            end
            if cutscene:getCharacter("susie") then
                cutscene:walkTo("susie", "placeS", 1)
            end
            cutscene:wait(1.2)
            if SD then
                SD:setFacing("down")
            end
            if cutscene:getCharacter("Honeywisp") then
                cutscene:getCharacter("Honeywisp"):setFacing("down")
            end
            if cutscene:getCharacter("susie") then
                cutscene:getCharacter("susie"):setFacing("down")
            end
            cutscene:text("* [speed:0.7]What is that...?", "Confused", "SD")
            cutscene:text("* (SD picked up the [color:yellow]Vine[color:reset])")
            cutscene:text("* A...[wait:1] Vine?", "Confused", "SD")
            cutscene:text("* Well...", "idle", "SD")
            local r1, r2 = Game.inventory:tryGiveItem("basic_vine")
            Kristal.Console:log(r2)
            cutscene:text("* Could be useful?", "Confused", "SD")
            cutscene:text("* As a [color:red]weapon[color:reset]?", "Confused", "SD")
            cutscene:text(r2)
            cutscene:wait(1)
            cutscene:text("* (Why was it just... there?)", "Confused", "SD")
            if cutscene:getCharacter("susie") then
                local susie = cutscene:getCharacter("susie")
                susie = susie:convertToNPC({ cutscene = "Cellphone.Call" })
            end
            --cutscene:alignFollowers()
            --cutscene:wait(cutscene:attachFollowers())
        end
    end,
    bigger = function(cutscene, battler, enemy)
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                cutscene:text("* ...", "Confused", "SD")
                cutscene:text("* Did the... [wait:0.6]area just get bigger?", "Confused", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* W-wasn't the area just smaller a second earlier...?", "confused", "Honeywisp")
            end
        else
            cutscene:text("* ...", "Confused", "SD")
            cutscene:text("* Did the... [wait:0.6]area just get bigger?", "Confused", "SD")
        end
    end,
    fight = function(cutscene, battler, enemy)
        local x, y = Game.world.camera:getPosition()
        cutscene:detachCamera()
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                cutscene:text("* ...", "idle", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* What is that...?", "confused", "Honeywisp")
            end
        else
            cutscene:text("* ...", "idle", "SD")
        end
        cutscene:panTo(x, y + 100, 2)
        Game.world.camera:panTo(x, y + 100, 2)
        local npc = cutscene:spawnNPC("Test", x - 100, y + 300)
        local Sushi = cutscene:getCharacter("Test")
        cutscene:wait(2.5)
        cutscene:startEncounter("Enemy", nil, Sushi)
        npc:remove()
        cutscene:attachCamera()
    end
}
