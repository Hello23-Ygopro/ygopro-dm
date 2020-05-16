--Kyrstron, Lair Delver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--to battle zone
function scard.tbfilter(c)
	return c:IsRaceCategory(RACECAT_DRAGON)
end
scard.tg1=aux.SendtoBZoneTarget(scard.tbfilter,LOCATION_HAND,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_HAND,0,1)
