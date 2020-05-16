--ディープ・オペレーション
--Deep Operation
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
