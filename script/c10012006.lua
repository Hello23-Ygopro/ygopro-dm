--Ularus, Punishment Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--confirm shield
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.ShieldZoneFilter(Card.IsFacedown)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and f(chkc) end
	if chk==0 then return Duel.IsExistingTarget(f,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	Duel.SelectTarget(tp,f,tp,LOCATION_SZONE,LOCATION_SZONE,ct,ct,nil)
end
scard.op1=aux.TargetConfirmOperation(true)
