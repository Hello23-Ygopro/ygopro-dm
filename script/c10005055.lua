--Smash Horn Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (power up)
	aux.EnableUpdatePower(c,1000)
	aux.AddStaticEffectUpdatePower(c,1000,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
