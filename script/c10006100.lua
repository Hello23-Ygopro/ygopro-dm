--Forbidding Totem
--WORK IN PROGRESS
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--redirect attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--redirect attack
function scard.redfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_MYSTERY_TOTEM)
end
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttacker():GetControler()~=tp
		and Duel.IsExistingMatchingCard(scard.redfilter,tp,LOCATION_BZONE,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATTACKTARGET)
	local g=Duel.SelectMatchingCard(1-tp,scard.redfilter,1-tp,0,LOCATION_BZONE,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.ChangeAttackTarget(g:GetFirst())
end
