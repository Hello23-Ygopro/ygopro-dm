--Wyn, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--confirm shield
scard.tg1=aux.CheckCardFunction(aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE)
scard.op1=aux.ConfirmOperation(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE,1)
