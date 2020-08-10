--Larba Geer, the Immaculate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	aux.AddEvolutionRaceList(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GUARDIAN))
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.TapOperation(nil,scard.posfilter,0,LOCATION_BZONE))
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToTap()
end
