--Brood Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (return)
function scard.retfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.retfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsCreature),LOCATION_MZONE,0,1)
