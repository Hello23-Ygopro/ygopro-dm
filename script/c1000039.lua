--Q-tronic Omnistrain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SURVIVOR))
	--add race
	aux.EnableAddRace(c,RACE_SURVIVOR,LOCATION_BZONE,0)
end
scard.evolution_race_list={RACE_SURVIVOR}
