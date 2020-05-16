--Muramasa, Duke of Blades
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--destroy
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
scard.tg1=aux.CheckCardFunction(scard.desfilter,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
