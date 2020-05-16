--Aeropica
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability (return)
function scard.retfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.retfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation()
