--Snaptongue Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,nil,scard.con1)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
end
--cannot be blocked
function scard.con1(e)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup()
end
