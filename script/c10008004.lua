--Magmadragon Jagalzor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOLCANO_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--speed attacker
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPEED_ATTACKER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_BZONE,0)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--reset speed attacker
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e2)
	e3:SetCondition(scard.con1)
	e3:SetOperation(scard.op2)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
--reset speed attacker
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_BZONE) or not c:IsFaceup()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local e1=e:GetLabelObject()
	e1:Reset()
	e:Reset()
end
--[[
	Rulings
	Q: If one of my other creature's break a shield, and the shield broken is a Terror Pit that is used to destroy
	Magmadragon Jagalzor, do my other creatures still gain its Turbo Rush ability of speed attacker that turn?
		A: No. Magmadragon Jagalzor's effect terminates once he leaves the field.
	https://duelmasters.fandom.com/wiki/Magmadragon_Jagalzor/Rulings
]]
