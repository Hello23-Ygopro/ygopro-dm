--Wise Starnoid, Avatar of Hope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STARNOID)
	aux.AddEvolutionRaceList(c,RACE_LIGHT_BRINGER,RACE_CYBER_LORD)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter1,scard.evofilter2)
	--to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
	aux.AddSingleTriggerEffectLeaveBZone(c,0,nil,nil,aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_LIGHT_BRINGER)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_LORD)
