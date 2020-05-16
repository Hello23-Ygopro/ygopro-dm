--Dracodance Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy replace (to mana zone, return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.con1)
end
--destroy replace (to mana zone, return)
function scard.con1(e)
	return Duel.IsExistingMatchingCard(aux.ManaZoneFilter(Card.IsRaceCategory),e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,RACECAT_DRAGON)
end
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToMZone)
function scard.thfilter(c)
	return c:IsRaceCategory(RACECAT_DRAGON) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoMZone(e:GetHandler(),POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
