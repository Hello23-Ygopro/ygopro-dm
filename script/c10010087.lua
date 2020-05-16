--Legacy Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (power attacker)
	aux.AddStaticEffectPowerAttacker(c,3000,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATIONS_LF))
end
