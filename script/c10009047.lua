--Dance of the Sproutlings
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to mana zone
function scard.tmfilter(c,race)
	return c:DMIsRace(race) and c:IsAbleToMZone()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCERACE)
	local race=Duel.DMAnnounceRace(tp)
	local ct=Duel.GetMatchingGroupCount(scard.tmfilter,tp,LOCATION_HAND,0,e:GetHandler(),race)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tmfilter,tp,LOCATION_HAND,0,0,ct,e:GetHandler(),race)
	if g:GetCount()==0 then return end
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
