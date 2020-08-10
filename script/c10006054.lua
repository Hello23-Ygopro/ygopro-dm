--Frost Specter, Shadow of Age
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	aux.AddEvolutionRaceList(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GHOST))
	--get ability (slayer)
	aux.AddStaticEffectSlayer(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.DMIsRace,RACE_GHOST))
end
