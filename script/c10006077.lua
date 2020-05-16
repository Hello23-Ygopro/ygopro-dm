--Cocco Lupia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	aux.AddNameCategory(c,NAMECAT_LUPIA)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-2,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
