--Wingeye Moth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_DRAW,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	if g:GetCount()==0 then return false end
	local tg=g:GetMaxGroup(Card.GetPower)
	return ep==tp and r==REASON_RULE and tg:IsExists(Card.IsControler,1,nil,tp)
end
--[[
	References
		1. Double Cipher
		https://github.com/Fluorohydride/ygopro-scripts/blob/51d2a9e/c63992027.lua#L17
]]
