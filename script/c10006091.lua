--Bliss Totem, Avatar of Luck
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (to mana zone)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (to mana zone)
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(Card.IsAbleToMZone),LOCATION_GRAVE,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,aux.DMGraveFilter(),LOCATION_GRAVE,0,0,3)
