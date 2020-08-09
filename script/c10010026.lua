--Static Warp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--tap
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TARGET)
	Duel.SelectTarget(1-tp,Card.IsFaceup,1-tp,LOCATION_BZONE,0,1,1,nil)
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	local g2=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	g1:Sub(g2)
	Duel.Tap(g1,REASON_EFFECT)
end
--[[
	References
	* The Shallow Grave
	https://github.com/Fluorohydride/ygopro-scripts/blob/2f8b6d0/c43434803.lua#L16
]]
