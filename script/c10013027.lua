--邪脚護聖ブレイガー
--Breiga, the Wicked Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--saver (all races)
	aux.AddReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.val1)
end
--saver (all races)
function scard.savefilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:IsHasRace()
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:FilterCount(scard.savefilter,c,tp)==1 and c:IsDestructable(e) end
	return Duel.SelectYesNo(tp,aux.Stringid(sid,1))
end
function scard.val1(e,c)
	return scard.savefilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
