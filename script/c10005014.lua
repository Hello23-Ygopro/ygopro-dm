--Syforce, Aurora Elemental
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--return
function scard.thfilter(c)
	return c:IsSpell() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.thfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(Card.IsSpell),LOCATION_MZONE,0,1)
