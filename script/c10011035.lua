--Eviscerating Warrior Lumez
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (destroy)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.WaveStrikerCondition)
end
--wave striker (destroy)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
scard.op1=aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE)
