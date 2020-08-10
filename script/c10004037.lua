--Skeleton Thief, the Revealer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_DEAD)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--return
function scard.thfilter(c)
	return c:DMIsRace(RACE_LIVING_DEAD) and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0,1)
