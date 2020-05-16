--Bladerush Skyterror Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,nil,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
