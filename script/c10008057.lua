--Emperor Quazla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	aux.AddEvolutionRaceList(c,RACE_CYBER_LORD)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_LORD))
	--draw
	aux.AddTriggerEffectPlayerUseShieldTrigger(c,0,PLAYER_OPPO,nil,nil,aux.DrawUpToOperation(PLAYER_SELF,2))
end
