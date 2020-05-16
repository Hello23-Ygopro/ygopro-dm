--Choya, the Unheeding
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power attacker
	aux.EnablePowerAttacker(c,1000)
	--no battle
	aux.EnableEffectCustom(c,EFFECT_NO_BE_BLOCKED_BATTLE)
end
