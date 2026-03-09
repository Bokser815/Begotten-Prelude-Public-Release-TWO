local PLUGIN = PLUGIN
local support = {
	civilProtection = true,
	combineOverwatch = true,
	maleHuman = true,
	femaleHuman = true
}

local whitelist = {
	[ACT_MP_STAND_IDLE] = true,
	[ACT_MP_CROUCH_IDLE] = true,
	[ACT_IDLE] = true,
	[ACT_COVER_LOW] = true,
	[ACT_COVER_PISTOL_LOW] = true,
	[ACT_RANGE_ATTACK_PISTOL] = true,
	[ACT_IDLE_ANGRY_PISTOL] = true,
	[ACT_IDLE_SMG1] = true,
	[ACT_IDLE_SMG1_RELAXED] = true,
	[ACT_IDLE_ANGRY_SMG1] = true,
	[ACT_COVER_LOW_RPG] = true,
	[ACT_IDLE_SUITCASE] = true,
	[ACT_IDLE_SHOTGUN_RELAXED] = true,
	[ACT_IDLE_MANNEDGUN] = true,
	[ACT_IDLE_ANGRY_MELEE] = true,
	[ACT_IDLE_SHOTGUN_AGITATED] = true,
	[ACT_IDLE_ANGRY_RPG] = true,
	[ACT_IDLE_SUITCASE] = true
}

function PLUGIN:TranslateActivity(player, act)
	local modelClass = Clockwork.animation:GetModelClass(player:GetModel())
	if not support[modelClass] or not whitelist[act] then return end
	player.NextTurn = player.NextTurn or 0
	local diff = math.NormalizeAngle(player:GetRenderAngles().y - player:EyeAngles().y)
	if math.abs(diff) >= 45 and player.NextTurn <= CurTime() then
		local gesture = diff > 0 and ACT_GESTURE_TURN_RIGHT90 or ACT_GESTURE_TURN_LEFT90
		if Clockwork.player:GetWeaponRaised(player) and gesture == ACT_GESTURE_TURN_LEFT90 then gesture = ACT_GESTURE_TURN_LEFT45 end
		player:AnimRestartGesture(GESTURE_SLOT_CUSTOM, gesture, true)
		player.NextTurn = CurTime() + player:SequenceDuration(player:SelectWeightedSequence(gesture))
	end
end