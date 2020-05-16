--Raza Vega, Thunder Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--destroy replace (to shield zone)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (to shield zone)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToSZone)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoSZone)
