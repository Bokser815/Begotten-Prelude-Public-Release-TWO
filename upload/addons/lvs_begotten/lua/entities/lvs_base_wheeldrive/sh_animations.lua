
function ENT:CalcMainActivityPassenger( ply )
	
end

function ENT:CalcMainActivity( ply )
	--if ply ~= self:GetDriver() then return self:CalcMainActivityPassenger( ply ) end
	local GunnerSeat =nil
	if self.GetGunnerSeat then

		GunnerSeat = self:GetGunnerSeat()

	end

	

	if ply.m_bWasNoclipping then 
		ply.m_bWasNoclipping = nil 
		ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 
		
		if CLIENT then 
			ply:SetIK( true )
		end 
	end 

	ply.CalcIdeal = ACT_STAND
	if IsValid( GunnerSeat ) and GunnerSeat:GetDriver() == ply then
		ply.CalcSeqOverride = ply:LookupSequence( "Man_Gun" )
	else
		ply.CalcSeqOverride = ply:LookupSequence( "silo_sit" )
	end
	

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function ENT:UpdateAnimation( ply, velocity, maxseqgroundspeed )
	ply:SetPlaybackRate( 1 )

	if CLIENT then
		if ply == self:GetDriver() then
			ply:SetPoseParameter( "vehicle_steer", self:GetSteer() /  self:GetMaxSteerAngle() )
			ply:InvalidateBoneCache()
		end

		GAMEMODE:GrabEarAnimation( ply )
		GAMEMODE:MouthMoveAnimation( ply )
	end

	return false
end
