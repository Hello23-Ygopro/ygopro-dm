--Re Bil, Seeker of Archery
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_LIGHT))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
