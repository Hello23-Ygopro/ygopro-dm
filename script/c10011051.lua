--Rise and Shine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--confirm deck (to hand)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,4)
	local g=Duel.GetDecktopGroup(tp,4)
	if g:IsExists(scard.thfilter,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,scard.thfilter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		aux.SortDeck(tp,tp,3,SEQ_DECK_BOTTOM)
	else aux.SortDeck(tp,tp,4,SEQ_DECK_BOTTOM) end
end
