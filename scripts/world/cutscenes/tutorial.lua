return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    weapon_get = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        local SD = cutscene:getCharacter("SD")
        local susie = cutscene:getCharacter("susie")
        local HW = cutscene:getCharacter("Honeywisp")
        cutscene:detachFollowers()
        cutscene:text("* ...huh?", "Confused", "SD")
        cutscene:walkTo("SD", "place", 1)
        cutscene:walkTo("Honeywisp", "placeH", 1)
        cutscene:walkTo("susie", "placeS", 1)
        cutscene:wait(1.2)
        SD:setFacing("down")
        HW:setFacing("down")
        susie:setFacing("down")
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
        susie = susie:convertToNPC({ cutscene = "Cellphone.Call" })
        --cutscene:alignFollowers()
        --cutscene:wait(cutscene:attachFollowers())
    end
}
