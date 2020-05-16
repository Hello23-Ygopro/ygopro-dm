--カラミティ・ドラゴン
--Calamity Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--power attacker
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_ATTACK_ANNOUNCE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetOperation(scard.op1)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetLabelObject(e0)
	e1:SetCondition(aux.SelfAttackerCondition)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	aux.EnableEffectCustom(c,EFFECT_POWER_ATTACKER)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,1,scard.con2)
end
--power attacker
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local os=require('os')
	math.randomseed(os.time())
	local t={5000,6000,7000,8000,9000,10000,11000,12000,13000,14000}
	local val=t[math.random(#t)]
	e:SetLabel(val)
end
function scard.val1(e,c)
	return e:GetLabelObject():GetLabel()
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(12000)
end
