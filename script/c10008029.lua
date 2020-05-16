--Gachack, Mechanical Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
	--turbo rush
	aux.EnableTurboRush(c,scard.op1)
end
--turbo rush
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(aux.AND(aux.AttackPlayerCondition,aux.UnblockedCondition))
	e1:SetOperation(aux.DestroyOperation(tp,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE,1))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
