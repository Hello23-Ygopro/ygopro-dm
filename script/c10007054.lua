--Tangle Fist, the Weaver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (to mana zone)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (to mana zone)
scard.tg1=aux.CheckCardFunction(Card.IsAbleToMZone,LOCATION_HAND,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0,1,3)
