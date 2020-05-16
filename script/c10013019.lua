--電磁無頼アカシック・サード
--Akashic Third, the Electro-Bandit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_BEAST_FOLK)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck (copy, to grave)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,aux.AttackTargetCondition())
	aux.AddSingleTriggerEffect(c,0,EVENT_BE_BATTLE_TARGET,nil,nil,scard.op1)
end
--confirm deck (copy, to grave)
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
		Duel.DMSendDecktoptoGrave(tp,dcount-seq,REASON_EFFECT)
		return
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if crcard:IsCreature() then
		local code=crcard:GetCode()
		local c=e:GetHandler()
		--copy name
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		--copy type
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetLabelObject(e1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetValue(crcard:GetType())
		c:RegisterEffect(e2)
		--copy mana cost
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CHANGE_MANA_COST)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetLabelObject(e2)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e3:SetValue(crcard:GetManaCost())
		c:RegisterEffect(e3)
		--copy civilization
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CHANGE_CIVILIZATION)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e4:SetLabelObject(e3)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e4:SetValue(crcard:GetCivilization())
		c:RegisterEffect(e4)
		--copy power
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_SET_POWER)
		e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e5:SetLabelObject(e4)
		e5:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e5:SetValue(crcard:GetPower())
		c:RegisterEffect(e5)
		--copy effect
		local cid=c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,2))
		--reset copy
		local e6=Effect.CreateEffect(c)
		e6:SetDescription(aux.Stringid(sid,1))
		e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e6:SetCode(EVENT_PHASE+PHASE_END)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e6:SetRange(LOCATION_BZONE)
		e6:SetCountLimit(1)
		e6:SetLabel(cid)
		e6:SetLabelObject(e5)
		e6:SetOperation(scard.op2)
		e6:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e6)
	end
	Duel.DisableShuffleCheck()
	Duel.DMSendDecktoptoGrave(tp,dcount-seq,REASON_EFFECT)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	local e5=e:GetLabelObject()
	local e4=e5:GetLabelObject()
	local e3=e4:GetLabelObject()
	local e2=e3:GetLabelObject()
	local e1=e2:GetLabelObject()
	e1:Reset()
	e2:Reset()
	e3:Reset()
	e4:Reset()
	e5:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--[[
	References
		1. Phantom of Chaos
		https://github.com/Fluorohydride/ygopro-scripts/blob/c04a9da/c30312361.lua#L40
		2. Number 8: Heraldic King Genom-Heritage
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c47387961.lua#L32
]]
