--偶発と弾幕の要塞
--Fortification Against Barrage and Ambush
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--confirm deck (destroy, to grave)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (destroy, to grave)
function scard.desfilter(c,pwr)
	return c:IsFaceup() and c:GetPower()<pwr
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsCreature,tp,LOCATION_DECK,0,nil)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if dcount==0 then return end
	local seq=-1
	local crcard=nil
	for tc in aux.Next(g1) do
		if tc:GetSequence()>seq then
			seq=tc:GetSequence()
			crcard=tc
		end
	end
	if seq==-1 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.DMSendDecktoGrave(tp,dcount-seq,REASON_EFFECT)
		return
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if crcard:IsCreature() then
		local g2=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,crcard:GetPower())
		Duel.Destroy(g2,REASON_EFFECT)
	end
	Duel.DisableShuffleCheck()
	Duel.DMSendDecktoGrave(tp,dcount-seq,REASON_EFFECT)
end
