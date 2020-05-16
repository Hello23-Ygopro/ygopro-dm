--Lena, Vizier of Brilliance
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--return
function scard.retfilter(c)
	return c:IsSpell() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.retfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsSpell),LOCATION_MZONE,0,1)
