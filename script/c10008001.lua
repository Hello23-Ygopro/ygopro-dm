--Kuukai, Finder of Karma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER)
	aux.AddEvolutionRaceList(c,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_MECHA_THUNDER))
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,nil,aux.SelfUntapOperation(),nil,aux.SelfBlockCondition)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
