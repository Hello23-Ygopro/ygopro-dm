--Blazosaur Q
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--survivor (power attacker)
	aux.EnablePowerAttacker(c,1000)
	aux.AddStaticEffectPowerAttacker(c,1000,LOCATION_ALL,0,aux.TargetBoolFunctionExceptSelf(Card.DMIsRace,RACE_SURVIVOR))
end
