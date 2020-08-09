--Slaphappy Soldier Galback
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(4000)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CHAIN_LIMIT+EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(aux.TargetCardFunction(tp,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_DESTROY))
	e1:SetOperation(aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
--[[
	Notes
	* This card's effect is different in the OCG.
]]
