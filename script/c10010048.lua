--Gigamente
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (return)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (return)
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsCreature),LOCATION_GRAVE,0,1)
