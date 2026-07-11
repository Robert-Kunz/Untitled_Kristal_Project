return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    Barracuda = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local x, y = cutscene:getMarker("camera_spot")
        local npc = cutscene:spawnNPC("Barracuda", x + 250, y + 50)
        local cuda = cutscene:getCharacter("Barracuda")
        cutscene:detachCamera()
        local SD = cutscene:getCharacter("SD")
        cutscene:detachFollowers()
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                cutscene:text("* ...huh?", "Confused", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* ???", "confused", "Honeywisp")
            end
        else
            cutscene:text("* ...huh?", "Confused", "SD")
        end
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
        if Game:getFlag("Solo_run", false) then
            if Game:getFlag("SD_solo", false) then
                cutscene:text("* ...", "idle", "Barracuda")
                cutscene:text("* YOU DARE TRESPASS ON THE BOSS' TERRITORY?", "idle", "Barracuda")
                cutscene:text("* Oh my god...", "Tired", "SD")
                cutscene:text("* Look, man, I'm just-", "idle", "SD", { auto = true })
                cutscene:text("* SHUT IT.", "angry", "Barracuda")
                cutscene:text("* ANYONE WHO TRESPASSES [color:red]DIES[color:reset]", "idle", "Barracuda")
                cutscene:text("* I AM A FRIEND, BARRACUDA.", "Annoyed", "SD")
                cutscene:text("* LIES.", "angry", "Barracuda")
                cutscene:text("* YOU ARE A LIAR!", "angry", "Barracuda")
                cutscene:text("* NOW LEAVE!", "angry", "Barracuda")
                cutscene:text("* ...[wait:1]OR ELSE...", "awakened", "Barracuda")
                cutscene:wait(1)
                cutscene:text("* Well we don't have any other option, do we, [color:red]Player[color:reset]?", "Hopeless",
                    "SD")
                cutscene:startEncounter("Barracuda", nil, cuda)
                npc:remove()
                cutscene:text("* Let's hope he learned his lesson...", "idle", "SD")
            elseif Game:getFlag("HW_solo", false) then
                cutscene:text("* ...", "idle", "Barracuda")
                cutscene:text("* YOU DARE TRESPASS ON THE BOSS' TERRITORY?", "idle", "Barracuda")
                cutscene:text("* W-wait-", "Scared", "Honeywisp", { auto = true })
                cutscene:text("* SHUT IT.", "angry", "Barracuda")
                cutscene:text("* ANYONE WHO TRESPASSES [color:red]DIES[color:reset]", "idle", "Barracuda")
                cutscene:text("* I-I don't mean h-harm!", "Scared", "Honeywisp")
                cutscene:text("* LIES.", "angry", "Barracuda")
                cutscene:text("* YOU ARE A LIAR!", "angry", "Barracuda")
                cutscene:text("* NOW LEAVE!", "angry", "Barracuda")
                cutscene:text("* ...[wait:1]OR ELSE...", "awakened", "Barracuda")
                cutscene:wait(1)
                cutscene:text("* No option left for you, Honeywisp", "smile", "soul")
                cutscene:text("* W-who said that?", "Scared", "Honeywisp")
                cutscene:text("* ...", "idle", "Honeywisp")
                cutscene:text("* G-Guess I'll have to convince him...?", "idle", "Honeywisp")
                cutscene:startEncounter("Barracuda", nil, cuda)
                npc:remove()
                cutscene:text("* h-he exploded?!", "Scared", "Honeywisp")
                cutscene:text("* Yah", "grin", "soul")
                cutscene:text("* W-Who's saying that?!", "confused", "Honeywisp")
                cutscene:text("* ...", "confused", "Honeywisp")
                cutscene:text("* Okay.", "look_down", "Honeywisp")
            end
        else
            cutscene:text("* ...", "idle", "Barracuda")
            cutscene:text("* YOU DARE TRESPASS ON THE BOSS' TERRITORY?", "idle", "Barracuda")
            cutscene:text("* Oh my god...", "Tired", "SD")
            cutscene:text("* Look, man, We're just-", "idle", "SD", { auto = true })
            cutscene:text("* SHUT IT.", "angry", "Barracuda")
            cutscene:text("* ANYONE WHO TRESPASSES [color:red]DIES[color:reset]", "idle", "Barracuda")
            cutscene:text("* W-we don't mean h-harm!", "Scared", "Honeywisp")
            cutscene:text("* WE'RE FRIENDS, BARRACUDA.", "Annoyed", "SD")
            cutscene:text("* LIES.", "angry", "Barracuda")
            cutscene:text("* YOU'RE ALL LIARS!", "angry", "Barracuda")
            cutscene:text("* NOW LEAVE!", "angry", "Barracuda")
            cutscene:text("* ...[wait:1]OR ELSE...", "awakened", "Barracuda")
            cutscene:wait(1)
            cutscene:text("* Well we don't have any other option, do we?", "Hopeless", "SD")
            cutscene:text("* ...", "thinking", "Honeywisp")
            cutscene:text("* I-I guess... w-we don't...", "idle", "Honeywisp")
            cutscene:startEncounter("Barracuda", nil, cuda)
            npc:remove()
            cutscene:text("* Let's hope he learned his lesson...", "idle", "SD")
            cutscene:text("* D-didn't he explode?!", "Scared", "Honeywisp")
            cutscene:text("* Oh, he'll regenerate...[wait:3] I hope", "idle", "SD")
        end
        cutscene:alignFollowers()
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end
}
