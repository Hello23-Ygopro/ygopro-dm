--Dew Mushroom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BALLOON_MUSHROOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost up
	aux.EnableUpdatePlayCost(c,1,LOCATION_ALL,LOCATION_ALL,scard.tg1)
	aux.EnableUpdatePlayCost(c,1,LOCATION_ALL,LOCATION_ALL,scard.tg2)
end
--cost up
function scard.tg1(e,c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.tg2(e,c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
