--Gonta, the Warrior Savage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
end
