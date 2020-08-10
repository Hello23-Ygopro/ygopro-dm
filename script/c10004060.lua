--Niofa, Horned Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HORNED_BEAST)
	aux.AddEvolutionRaceList(c,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_HORNED_BEAST))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--search (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,true))
end
--search (to hand)
function scard.thfilter(c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_NATURE)
end
