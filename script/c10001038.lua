--Saucer-Head Shark
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GEL_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(nil,scard.retfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--return
function scard.retfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
