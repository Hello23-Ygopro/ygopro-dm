--Fever Nuts
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsCreature))
end
