--Brad, Super Kickin' Dynamo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (destroy)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1)
end
--silent skill (destroy)
function scard.desfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
scard.tg1=aux.CheckCardFunction(scard.desfilter,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,scard.desfilter,0,LOCATION_BZONE,1)
