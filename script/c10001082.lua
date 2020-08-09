--Meteosaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
--[[
	Notes
	* This card's effect is different in the OCG.
]]
