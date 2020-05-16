--Bad Axe Norsykler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--power attacker
	aux.EnablePowerAttacker(c,4000)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
