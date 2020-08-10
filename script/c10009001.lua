--Glena Vuele, the Hypnotic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	aux.AddEvolutionRaceList(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GUARDIAN))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddTriggerEffectPlayerUseShieldTrigger(c,0,PLAYER_OPPO,true,scard.tg1,scard.op1)
end
--to shield zone
scard.tg1=aux.DecktopSendtoSZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1)
