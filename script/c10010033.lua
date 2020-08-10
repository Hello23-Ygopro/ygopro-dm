--Crystal Spinslicer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	aux.AddEvolutionRaceList(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_LIQUID_PEOPLE))
end
