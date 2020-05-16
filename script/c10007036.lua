--Apocalypse Vise
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy
function scard.desfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerAbove(0) and c:IsPowerBelow(pwr)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local pwr=8000
	local g=Duel.GetMatchingGroup(scard.desfilter,tp,0,LOCATION_BZONE,nil,pwr)
	local dg=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local tc=g:Select(tp,0,1,nil):GetFirst()
		if not tc then break end
		Duel.HintSelection(Group.FromCards(tc))
		dg:AddCard(tc)
		g:RemoveCard(tc)
		pwr=pwr-tc:GetPower()
		g=g:Filter(scard.desfilter,nil,pwr)
	until pwr<=0 or g:GetCount()==0
	Duel.Destroy(dg,REASON_EFFECT)
end
--[[
	References
		1. Ninjitsu Art of Duplication
		https://github.com/Fluorohydride/ygopro-scripts/blob/db63e8c/c50766506.lua#L41
]]
