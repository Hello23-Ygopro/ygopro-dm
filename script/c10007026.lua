--Dream Pirate, Shadow of Theft
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy replace (return, to grave)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (return, to grave)
scard.tg1=aux.SingleReplaceDestroyTarget2(1,Card.IsAbleToHand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(e:GetHandler(),PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.DMIsAbleToGrave,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.DMSendtoGrave(g,REASON_EFFECT)
end
