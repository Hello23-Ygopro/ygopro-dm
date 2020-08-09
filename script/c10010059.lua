--Upheaval
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
	scard.return_card(tp)
	scard.return_card(1-tp)
end
function scard.return_card(tp)
	local g1=Duel.GetMatchingGroup(aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,nil)
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToMZone,tp,LOCATION_HAND,0,nil)
	g2:Sub(Duel.GetOperatedGroup())
	Duel.SendtoMZone(g2,POS_FACEUP_TAPPED,REASON_EFFECT)
end
--[[
	References
	* Morphing Jar #2
	https://github.com/Fluorohydride/ygopro-scripts/blob/b2c6aa3/c79106360.lua#L46
]]
