--Psychic Shaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--confirm deck (to hand, to grave)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (to hand, to grave)
function scard.thfilter(c)
	return c:IsCivilization(CIVILIZATION_WATER) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,4)
	local g=Duel.GetDecktopGroup(tp,4)
	local sg=g:Filter(scard.thfilter,nil)
	g:Sub(sg)
	Duel.DisableShuffleCheck()
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
	end
	Duel.DMSendtoGrave(g,REASON_EFFECT)
end
--[[
	References
		1. Ma'at
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c18631392.lua#L71
		2. Spellbook Library of the Heliosphere
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c20822520.lua#L65
]]
