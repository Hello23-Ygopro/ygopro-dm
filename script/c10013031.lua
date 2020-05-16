--炎槍と水剣の裁
--Judgement of the Flame's Spear and the Water's Blade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy, draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy, draw
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct==0 or not Duel.IsPlayerCanDraw(tp,1) or not Duel.SelectYesNo(tp,YESNOMSG_DRAW) then return end
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
