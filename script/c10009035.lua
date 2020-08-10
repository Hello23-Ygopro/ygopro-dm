--Zombie Carnival
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--return
function scard.thfilter(c,race)
	return c:DMIsRace(race) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCERACE)
	local race=Duel.DMAnnounceRace(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.DMGraveFilter(scard.thfilter),tp,LOCATION_GRAVE,0,0,3,nil,race)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
