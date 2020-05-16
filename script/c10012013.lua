--Mechadragon's Breath
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--destroy
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(6000)
end
function scard.desfilter(c,pwr)
	return c:IsFaceup() and c:IsPower(pwr)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
	if g1:GetCount()==0 then return end
	local ag=Group.CreateGroup()
	local power_list={}
	for tc in aux.Next(g1) do
		local pwr=tc:GetPower()
		if not ag:IsExists(Card.IsPower,1,nil,pwr) then
			ag:AddCard(tc)
			table.insert(power_list,pwr)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCEPOWER)
	local an=Duel.AnnounceNumber(tp,table.unpack(power_list))
	local g2=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,an)
	Duel.Destroy(g2,REASON_EFFECT)
end
