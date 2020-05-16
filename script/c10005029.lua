--Horned Mutant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost up
	aux.EnableUpdatePlayCost(c,1,LOCATION_ALL,LOCATION_ALL,scard.tg1)
	aux.EnableUpdatePlayCost(c,1,LOCATION_ALL,LOCATION_ALL,scard.tg2)
end
--cost up
function scard.tg1(e,c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_NATURE)
end
function scard.tg2(e,c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_NATURE)
end
