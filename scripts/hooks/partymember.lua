local PartyMember, super = HookSystem.hookScript(PartyMember)

function PartyMember:canEquip(item, slot_type, slot_index)
    if item then
        return item:canEquip(self, slot_type, slot_index)
    else
        return true
    end
end

return PartyMember
