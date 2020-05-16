--Mummy Wrap, Shadow of Fatigue
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (discard)
	aux.EnableTapAbility(c,0,aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,LOCATION_HAND),scard.op1)
end
--tap ability (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.RandomDiscardHand(tp,1,REASON_EFFECT)
	Duel.RandomDiscardHand(1-tp,1,REASON_EFFECT)
end
