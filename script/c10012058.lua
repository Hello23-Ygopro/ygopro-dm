--Cruel Naga, Avatar of Fate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_NAGA)
	aux.AddEvolutionRaceList(c,RACE_MERFOLK,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter1,scard.evofilter2)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.AddSingleTriggerEffectLeaveBZone(c,0,nil,nil,aux.DestroyOperation(nil,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE))
end
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_MERFOLK)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CHIMERA)
