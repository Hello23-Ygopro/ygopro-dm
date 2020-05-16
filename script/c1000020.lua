--Amnis, Holy Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker (darkness)
	aux.EnableBlocker(c,nil,DESC_DARKNESS_BLOCKER,aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS))
	--cannot be destroyed
	aux.EnableCannotBeBattleDestroyed(c,scard.val1)
end
--cannot be destroyed
function scard.val1(e,c)
	return c:IsCivilization(CIVILIZATION_DARKNESS)
end
