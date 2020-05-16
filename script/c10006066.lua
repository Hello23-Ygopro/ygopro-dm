--Schuka, Duke of Amnesia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,nil,nil,aux.DiscardOperation(nil,aux.TRUE,LOCATION_HAND,LOCATION_HAND))
end
