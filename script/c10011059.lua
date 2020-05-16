--Miraculous Meltdown
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to hand
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetShieldCount(1-tp)>Duel.GetShieldCount(tp)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and aux.ShieldZoneFilter()(chkc) end
	if chk==0 then return true end
	local ct=Duel.GetShieldCount(tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TARGET)
	Duel.SelectTarget(1-tp,aux.ShieldZoneFilter(),1-tp,LOCATION_SZONE,0,ct,ct,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.ShieldZoneFilter(Card.IsAbleToHand),tp,0,LOCATION_SZONE,nil)
	local g2=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g2:GetCount()>0 then g1:Sub(g2) end
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT,true)
end
