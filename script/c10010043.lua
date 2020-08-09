--Transmogrify
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--destroy, confirm deck (to battle zone, to grave)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--destroy, confirm deck (to battle zone, to grave)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,LOCATION_BZONE,0,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.Destroy(g1,REASON_EFFECT)==0 then return end
	local p=g1:GetFirst():GetOwner()
	local g2=Duel.GetMatchingGroup(scard.tbfilter,p,LOCATION_DECK,0,nil,e,p)
	local dcount=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)
	if dcount==0 then return end
	local seq=-1
	local tbcard=nil
	for tc in aux.Next(g2) do
		if tc:GetSequence()>seq then
			seq=tc:GetSequence()
			tbcard=tc
		end
	end
	if seq==-1 then
		Duel.ConfirmDecktop(p,dcount)
		Duel.DMSendDecktoptoGrave(p,dcount-seq,REASON_EFFECT)
		return
	end
	Duel.ConfirmDecktop(p,dcount-seq)
	if tbcard:IsAbleToBZone(e,0,p,false,false) then
		Duel.DisableShuffleCheck()
		if dcount-seq==1 then Duel.SendtoBZone(tbcard,0,p,p,false,false,POS_FACEUP_UNTAPPED)
		else
			Duel.SendtoBZoneStep(tbcard,0,p,p,false,false,POS_FACEUP_UNTAPPED)
			Duel.DMSendDecktoptoGrave(p,dcount-seq-1,REASON_EFFECT)
			Duel.SendtoBZoneComplete()
		end
	else Duel.DMSendDecktoptoGrave(p,dcount-seq,REASON_EFFECT) end
end
--[[
	References
	* Monster Gate
	https://github.com/Fluorohydride/ygopro-scripts/blob/6418030/c43040603.lua#L26
]]
