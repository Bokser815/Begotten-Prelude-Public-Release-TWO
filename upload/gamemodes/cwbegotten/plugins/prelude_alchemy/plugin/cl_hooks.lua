function cwAlchemy:ClientAttemptCraft(player, item1, item2)
    hook.Run("CraftCompound", player, item1, item2);
end;

function cwAlchemy:ClientAttemptTransmute(player, compound, metal)
    hook.Run("Transmute", player, compound, metal);
end;

function cwAlchemy:ClientAttemptDisassemble(player, compound, equipment)
    hook.Run("Disassemble", player, compound, equipment);
end;
