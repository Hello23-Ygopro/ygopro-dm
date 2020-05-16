--Gigavrand
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,aux.DiscardOperation(nil,aux.TRUE,0,LOCATION_HAND),nil,scard.con1)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=0
		scard[1]=0
		--check cards drawn
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(scard.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(scard.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
--check cards drawn
function scard.checkop(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		if ep~=tp then
			scard[ep]=scard[ep]+1
		end
	end
end
function scard.clearop(e,tp,eg,ep,ev,re,r,rp)
	scard[0]=0
	scard[1]=0
end
--discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return scard[1-tp]>=2
end
--[[
	References
		1. Crystolic Potential
		https://github.com/Fluorohydride/ygopro-scripts/blob/96e0697/c3576031.lua#L33
]]
