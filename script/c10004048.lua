--Ancient Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS))
end
