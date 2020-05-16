--Misha, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
