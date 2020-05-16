--Magmarex
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPower(1000)
end
scard.op1=aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE)
