--Whisking Whirlwind
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--untap
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Untap(g,REASON_EFFECT)
end
--[[
	References
	* Prediction Princess Astromorrigan
	https://github.com/Fluorohydride/ygopro-scripts/blob/b81455f/c5010422.lua#L13
]]
