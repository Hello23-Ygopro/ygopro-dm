--Ambush Scorpion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCode(sid)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1,1,HINTMSG_TOBZONE)
scard.op1=aux.TargetSendtoBZoneOperation(PLAYER_SELF,POS_FACEUP_UNTAPPED)
