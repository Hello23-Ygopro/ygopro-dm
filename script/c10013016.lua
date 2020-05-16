--天使と悪魔の墳墓
--The Grave of Angels and Demons
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy, to grave
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy, to grave
function scard.desfilter(c,g)
	local code=c:GetCode()
	return g:IsExists(Card.IsCode,1,c,code)
end
function scard.tgfilter(c,g)
	local code=c:GetCode()
	return g:IsExists(Card.IsCode,1,c,code) and c:DMIsAbleToGrave()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	local dg=g1:Filter(scard.desfilter,nil,g1)
	Duel.Destroy(dg,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(aux.ManaZoneFilter(),tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tg=g2:Filter(scard.tgfilter,nil,g2)
	Duel.BreakEffect()
	Duel.DMSendtoGrave(tg,REASON_EFFECT)
end
--[[
	References
		1. Kotodama
		https://github.com/Fluorohydride/ygopro-scripts/blob/master/c19406822.lua
]]
