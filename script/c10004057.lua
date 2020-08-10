--King Aquakamui
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.DMIsRace,RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND))
end
--return
function scard.thfilter(c)
	return c:DMIsRace(RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND) and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(nil,aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0)
