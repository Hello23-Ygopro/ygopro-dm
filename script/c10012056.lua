--Terradragon Arque Delacerna
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--discard replace (to battle zone)
	aux.AddSingleReplaceEffectDiscard(c,0,scard.tg1,scard.op1,aux.TurnPlayerCondition(PLAYER_OPPO))
end
--discard replace (to battle zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_DISCARD) and not c:IsReason(REASON_REPLACE)
		and c:IsAbleToBZone(e,0,tp,false,false) end
	return Duel.SelectYesNo(tp,aux.Stringid(sid,1))
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoBZone(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
