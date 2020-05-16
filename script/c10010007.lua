--Carnival Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return, to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--return, to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,nil)
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToMZone,tp,LOCATION_HAND,0,nil)
	g2:Sub(Duel.GetOperatedGroup())
	Duel.SendtoMZone(g2,POS_FACEUP_TAPPED,REASON_EFFECT)
end
