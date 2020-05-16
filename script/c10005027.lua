--Gigaling Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (slayer)
	aux.EnableSlayer(c)
	aux.AddStaticEffectSlayer(c,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
