--Spikestrike Ichthys Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_FISH)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (cannot be blocked)
	aux.EnableCannotBeBlocked(c)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
