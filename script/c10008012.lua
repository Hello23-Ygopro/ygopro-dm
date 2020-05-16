--Sasha, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker (dragon)
	aux.EnableBlocker(c,nil,DESC_DRAGON_BLOCKER,aux.FilterBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
	--power up
	aux.EnableUpdatePower(c,6000,aux.SelfBattlingCondition(aux.FilterBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON)))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
