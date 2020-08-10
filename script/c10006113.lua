--Crystal Jouster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	aux.AddEvolutionRaceList(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_LIQUID_PEOPLE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy replace (return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (return)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
