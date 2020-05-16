--パシフィック・チャンピオン
--Pacific Champion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_MERFOLK))
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,aux.NOT(aux.TargetBoolFunction(Card.IsEvolution)))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.NOT(aux.CannotBeBlockedBoolFunction(Card.IsEvolution)))
end
scard.evolution_race_list={RACE_MERFOLK}
