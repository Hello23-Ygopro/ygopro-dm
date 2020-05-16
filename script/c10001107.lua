--Thorny Mandra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsCreature() and c:IsAbleToMZone()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.tmfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsCreature),LOCATION_GRAVE,0,1)
