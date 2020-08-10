--Cosmogold, Spectral Knight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_RAINBOW_PHANTOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (return)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (return)
function scard.thfilter(c)
	return c:IsSpell() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.thfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsSpell),LOCATION_MZONE,0,1)
