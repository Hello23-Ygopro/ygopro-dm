--Bluum Erkis, Flare Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--break replace (confirm shield - cast for no cost or to hand)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(scard.tg1)
	e1:SetValue(scard.val1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--break replace (confirm shield - cast for no cost or to hand)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_SZONE) and c:IsControler(1-tp)
		and c:GetDestination()~=LOCATION_SZONE and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler()==e:GetHandler()
		and eg:IsExists(scard.repfilter,1,nil,tp) and bit.band(r,REASON_BREAK)~=0 end
	local g=eg:Filter(scard.repfilter,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.castfilter(c)
	return c:IsSpell() and c:IsHasEffect(EFFECT_SHIELD_TRIGGER)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local g=e:GetLabelObject()
	Duel.ConfirmCards(tp,g)
	local sg1=g:Filter(scard.castfilter,nil)
	Duel.CastFree(sg1,REASON_EFFECT+REASON_REPLACE)
	local sg2=g:Filter(aux.NOT(scard.castfilter),nil)
	Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
end
