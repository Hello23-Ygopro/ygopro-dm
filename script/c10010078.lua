--Vorg's Engine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (destroy)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (destroy)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
scard.tg1=aux.CheckCardFunction(scard.desfilter,LOCATION_BZONE,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(nil,scard.desfilter,LOCATION_BZONE,LOCATION_BZONE)
