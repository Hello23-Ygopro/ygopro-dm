--Stallob, the Lifequasher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,nil,nil,aux.DestroyOperation(nil,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE))
end
