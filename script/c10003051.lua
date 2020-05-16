--Psyshroom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BALLOON_MUSHROOM)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsCivilization(CIVILIZATION_NATURE) and c:IsAbleToMZone()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.tmfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,aux.DMGraveFilter(scard.tmfilter),LOCATION_GRAVE,0,1)
