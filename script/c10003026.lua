--Gamil, Knight of Hatred
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--return
function scard.retfilter(c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_DARKNESS) and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0,1)