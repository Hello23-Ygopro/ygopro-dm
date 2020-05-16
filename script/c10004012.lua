--Milieus, the Daystretcher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cost up
	aux.EnableUpdatePlayCost(c,2,LOCATION_ALL,LOCATION_ALL,scard.tg1)
	aux.EnableUpdatePlayCost(c,2,LOCATION_ALL,LOCATION_ALL,scard.tg2)
end
--cost up
function scard.tg1(e,c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.tg2(e,c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
