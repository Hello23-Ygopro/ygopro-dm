--Pulsar Tree
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STARLIGHT_TREE)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield saver
	aux.EnableShieldSaver(c)
end
