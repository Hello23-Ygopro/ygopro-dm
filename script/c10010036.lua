--Mystic Magician
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (enter tapped)
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED,nil,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_SILENT_SKILL))
	--destroy replace (return)
	aux.AddReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.val1)
end
--destroy replace (return)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:IsHasEffect(EFFECT_SILENT_SKILL)
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(scard.repfilter,1,nil,tp) end
	local g=eg:Filter(scard.repfilter,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(e:GetLabelObject(),PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
end
