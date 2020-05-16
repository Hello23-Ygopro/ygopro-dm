--Thought Probe
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
	if Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)>=3 then
		Duel.Draw(tp,3,REASON_EFFECT)
	end
end
