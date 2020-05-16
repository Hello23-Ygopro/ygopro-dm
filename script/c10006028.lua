--Telitol, the Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
--confirm shield
scard.tg1=aux.CheckCardFunction(aux.ShieldZoneFilter(Card.IsFacedown),LOCATION_SZONE,0)
scard.op1=aux.ConfirmOperation(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),LOCATION_SZONE,0)
