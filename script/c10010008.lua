--Tanzanyte, the Awakener
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability (return)
function scard.retfilter1(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.DMGraveFilter(scard.retfilter1)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and f(chkc) end
	if chk==0 then return Duel.IsExistingTarget(f,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,aux.DMGraveFilter(Card.IsCreature),tp,LOCATION_GRAVE,0,1,1,nil):GetFirst()
	e:SetLabel(tc:GetCode())
end
function scard.retfilter2(c,code)
	return scard.retfilter1(c) and c:IsCode(code)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.DMGraveFilter(scard.retfilter2),tp,LOCATION_GRAVE,0,nil,e:GetLabel())
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
