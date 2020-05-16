--Lukia Lex, Pinnacle Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
	--untap
	aux.EnableTurnEndSelfUntap(c)
end
