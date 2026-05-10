function Mod:init()
    self.missingno_voice_timer = 0
    print("Loaded " .. self.info.name .. "!")
    Kristal.setPresence({
        state = "Testing Stuff",
        details = "Mod Name still to be defined :D",
        largeImageKey = "Placeholder",
        largeImageTest = "Testing v" .. tostring(Mod.Version),
        startTimestamp = os.time(),
        instance = 1,

    })
    Registry.registerGlobal("DISCORD_RPC_ID", "1491383229633269850")
    DISCORD_RPC_ID = "1491383229633269850"
end

function Mod:onTextSound(sound, node)
    if sound == "missingno" then
        if self.missingno_voice_timer == 0 then
            local rand = Utils.random(0, 15, 1) + 1
            Kristal.Console:log(rand)
            local file_stuff = "voice/missingno/glitch_" .. rand
            Kristal.Console:log(file_stuff)
            local snd = Utils.pick({ file_stuff })
            local pitch = 0.80 + Utils.random(0.2)
            Assets.playSound(snd, 0.7, pitch)
            self.missingno_voice_timer = 3
        end
        self.missingno_voice_timer = self.missingno_voice_timer - 0.5
        return true
    end
end
