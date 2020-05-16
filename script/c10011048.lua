--Rollicking Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTERY_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (to battle zone)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (to battle zone)
function scard.tbfilter(c)
	return c:IsRaceCategory(RACECAT_DRAGON)
end
scard.tg1=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1)
