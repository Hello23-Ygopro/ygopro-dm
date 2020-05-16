--Adomis, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability shield (confirm)
	aux.EnableTapAbility(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap ability shield (confirm)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),LOCATION_SZONE,LOCATION_SZONE,0,1,HINTMSG_CONFIRM)
scard.op1=aux.TargetConfirmOperation()
