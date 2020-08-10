--Grim Soul, Shadow of Reversal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (return)
function scard.thfilter(c)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_DARKNESS) and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(scard.thfilter),LOCATION_GRAVE,0,1)
