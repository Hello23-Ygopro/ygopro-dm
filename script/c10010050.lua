--Hourglass Mutant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (slayer)
	aux.AddStaticEffectSlayer(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATIONS_WF))
end
