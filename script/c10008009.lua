--Migalo, Vizier of Spycraft
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--confirm shield
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CHAIN_LIMIT)
	e1:SetTarget(aux.CheckCardFunction(aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE))
	e1:SetOperation(aux.ConfirmOperation(tp,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE,2))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
