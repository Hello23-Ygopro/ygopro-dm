--Estol, Vizier of Aqua
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to shield zone, confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to shield zone, confirm shield
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoSZone(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsFacedown),tp,0,LOCATION_SZONE,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.HintSelection(g)
	Duel.ConfirmCards(tp,g)
end
