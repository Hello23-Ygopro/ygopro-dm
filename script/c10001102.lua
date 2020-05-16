--Poisonous Mushroom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BALLOON_MUSHROOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to mana zone
scard.tg1=aux.CheckCardFunction(Card.IsAbleToMZone,LOCATION_HAND,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0,1)
