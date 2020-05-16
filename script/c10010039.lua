--Siren Concerto
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--return, to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--return, to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		Duel.ShuffleHand(tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToMZone,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	if g2:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoMZone(g2,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
