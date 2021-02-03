--Uncanny Turnip
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIES)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (to mana zone, return)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.WaveStrikerCondition)
end
--wave striker (to mana zone, return)
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
