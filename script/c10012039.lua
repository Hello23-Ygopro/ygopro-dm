--Pharzi, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--return
function scard.retfilter(c)
	return c:IsSpell() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsSpell),LOCATION_GRAVE,0,1)