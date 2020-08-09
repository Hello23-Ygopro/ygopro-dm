--剛勇傀儡ガシガシ
--Gashi Gashi, the Brave Puppet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--send replace (to mana zone)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CUSTOM+EVENT_LOSE_BATTLE)
	e2:SetCondition(scard.con2)
	c:RegisterEffect(e2)
end
--send replace (to mana zone)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	local g=Group.FromCards(c,tc)
	g:KeepAlive()
	e:SetLabelObject(g)
	return c:IsStatus(STATUS_BATTLE_DESTROYED) and tc and tc:IsStatus(STATUS_OPPO_BATTLE)
end
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Group.FromCards(c,c:GetBattleTarget())
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoMZone(e:GetLabelObject(),POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
--[[
	References
	* Dark Magician of Chaos
	https://github.com/Fluorohydride/ygopro-scripts/blob/a0db0e4/c40737112.lua#L21
	* Neo-Spacian Grand Mole
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c80344569.lua#L16
]]
