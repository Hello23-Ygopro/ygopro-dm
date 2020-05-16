--Obsidian Scarab
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCode(sid)
end
scard.tg1=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1)
