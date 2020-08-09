--Rapid Reincarnation
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy, to battle zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--destroy, to battle zone
function scard.tbfilter(c,e,tp,cost)
	return c:IsCreature() and c:IsManaCostBelow(cost)
		and c:IsAbleToBZone(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,0,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.Destroy(g1,REASON_EFFECT)==0 then return end
	local cost=Duel.GetManaCount(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g2=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,cost)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoBZone(g2,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
--[[
	Rulings
	Q: I choose an evolution creature in my hand, but I don't have a creature of the correct race in the battle zone.
	What happens?
		A: You can't put that evolution creature into the battle zone. It stays in your hand.
	https://duelmasters.fandom.com/wiki/Rapid_Reincarnation/Rulings
]]
