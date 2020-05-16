--Kipo's Contraption
--ピーポのバール (Pippo Crowbar)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_XENOPARTS)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (destroy)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1)
end
--tap ability (destroy)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
scard.tg1=aux.CheckCardFunction(scard.desfilter,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
