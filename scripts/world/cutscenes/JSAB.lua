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
        cutscene:text("* ...huh?", "Confused", "SD")
        cutscene:panTo(x, y, 2)
        Game.world.camera:panTo(x, y, 2)
        cutscene:walkTo("SD", "place", 1)
        if cutscene:getCharacter("Honeywisp") then
            cutscene:walkTo("Honeywisp", "placeH", 1)
        end
        cutscene:wait(1.2)
        SD:setFacing("right")
        if cutscene:getCharacter("Honeywisp") then
            cutscene:getCharacter("Honeywisp"):setFacing("right")
        end
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
        cutscene:alignFollowers()
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end
}
