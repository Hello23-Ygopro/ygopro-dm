--Armored Raider Gandaval
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	aux.AddEvolutionRaceList(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_HUMAN))
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*2000
end
