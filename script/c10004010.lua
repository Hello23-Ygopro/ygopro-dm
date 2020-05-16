--Gulan Rias, Speed Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS))
end
