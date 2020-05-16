--Innocent Hunter, Blade of All
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution any race
	aux.EnableEffectCustom(c,EFFECT_EVOLUTION_ANY_RACE)
end
