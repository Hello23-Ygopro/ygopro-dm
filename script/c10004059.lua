--Galklife Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_LIGHT) and c:IsPowerBelow(4000)
end
