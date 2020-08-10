--Cosmic Nebula
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	aux.AddEvolutionRaceList(c,RACE_CYBER_VIRUS)
	aux.AddEvolutionRaceCategoryList(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CYBER_VIRUS))
	--draw
	aux.AddTriggerEffect(c,0,EVENT_DRAW,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and r==REASON_RULE
end
