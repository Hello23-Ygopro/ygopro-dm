--Scream Slicer, Shadow of Fear
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--destroy
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp
		and (c:DMIsRace(RACE_DRAGO_NOID) or c:IsRaceCategory(RACECAT_DRAGON))
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	if g:GetCount()==0 then return end
	local dg=g:GetMinGroup(Card.GetPower)
	if dg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=dg:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	else
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
--[[
	References
	* Chthonian Blast
	https://github.com/Fluorohydride/ygopro-scripts/blob/13bb48a/c18271561.lua#L31
]]
