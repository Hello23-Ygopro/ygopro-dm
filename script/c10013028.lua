--血風神官フンヌー
--Funnoo, Officer of Bloody Winds
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SOLTROOPER,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BREAK_SHIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(scard.regcon1)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,aux.SelfDestroyOperation(),nil,scard.con1)
end
--destroy
function scard.regcon1(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsControler(1-tp)
end
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0
end
