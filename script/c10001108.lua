--Tower Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsPowerBelow,4000))
end
