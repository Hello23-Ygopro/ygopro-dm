--Pokolul
--Not fully implemented: Other tapped Pokolul can trigger even though they didn't break the current broken shield
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CUSTOM+EVENT_BREAK_SHIELD)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e0:SetRange(LOCATION_BZONE)
	e0:SetCondition(scard.regcon1)
	e0:SetOperation(scard.regop1)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(scard.regop2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(scard.regop3)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(sid,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(scard.con1)
	e3:SetTarget(aux.SelfUntapTarget)
	e3:SetOperation(scard.op1)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
--untap
function scard.regcon1(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()==e:GetHandler()
end
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		ec:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
function scard.regop2(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function scard.regop3(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasCategory(CATEGORY_SHIELD_TRIGGER) or re:GetHandler():GetFlagEffect(sid)==0 then return end
	e:GetLabelObject():SetLabel(1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.Untap(c,REASON_EFFECT)
	--part of workaround to not tap a creature that untaps itself with an ability
	--Note: Remove this if YGOPro allows a creature to tap itself for EFFECT_ATTACK_COST
	c:RegisterFlagEffect(EFFECT_IGNORE_TAP,RESET_EVENT+RESETS_STANDARD,0,1)
end
