--Dimension Splitter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--return
function scard.retfilter(c)
	return c:IsRaceCategory(RACECAT_DRAGON) and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(nil,aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0)
