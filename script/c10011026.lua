--Gazer Eyes, Shadow of Secrets
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (discard)
	aux.EnableSilentSkill(c,0,aux.CheckCardFunction(aux.TRUE,0,LOCATION_HAND),scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--silent skill (discard)
function scard.dhfilter(c,e)
	return c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:FilterSelect(tp,scard.dhfilter,1,1,nil,e)
	Duel.SetTargetCard(sg)
	Duel.DMSendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
