--Chekicul, Vizier of Endurance
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--no battle
	aux.EnableEffectCustom(c,EFFECT_NO_BLOCK_BATTLE)
	--cannot attack
	aux.EnableCannotAttack(c)
end
