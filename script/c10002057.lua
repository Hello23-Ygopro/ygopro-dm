--Crystal Paladin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_LIQUID_PEOPLE))
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(nil,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE))
end
scard.evolution_race_list={RACE_LIQUID_PEOPLE}
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
