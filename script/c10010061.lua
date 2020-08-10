--Zero Nemesis, Shadow of Panic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	aux.AddEvolutionRaceList(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GHOST))
	--discard
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp)
end
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1,1,true)
