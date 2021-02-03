--Skysword, the Savage Vizier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone, to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to mana zone, to shield zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.SendDecktoSZone(tp,1)
end
