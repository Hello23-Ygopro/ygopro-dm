--Gallia Zohl, Iron Guardian Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (blocker)
	aux.EnableBlocker(c)
	aux.AddStaticEffectBlocker(c,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
