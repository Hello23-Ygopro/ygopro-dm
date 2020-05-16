--Lemik, Vizier of Thought
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATIONS_WN))
end
