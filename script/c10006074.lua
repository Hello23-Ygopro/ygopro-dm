--Badlands Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,3000)
	--no battle
	aux.EnableEffectCustom(c,EFFECT_NO_BE_BLOCKED_BATTLE)
end
