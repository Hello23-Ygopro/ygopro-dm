--Frei, Vizier of Air
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.EnableTurnEndSelfUntap(c)
end
