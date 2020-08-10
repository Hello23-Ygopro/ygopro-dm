--Frantic Chieftain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,0,1))
end
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(4)
end
