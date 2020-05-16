--Giliam, the Tormentor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker (light)
	aux.EnableBlocker(c,nil,DESC_LIGHT_BLOCKER,aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_LIGHT))
	--cannot be destroyed
	aux.EnableCannotBeBattleDestroyed(c,scard.val1)
end
--cannot be destroyed
function scard.val1(e,c)
	return c:IsCivilization(CIVILIZATION_LIGHT)
end
