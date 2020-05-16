--Pierr, Psycho Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--must block
	aux.EnableEffectCustom(c,EFFECT_MUST_BLOCK)
	--cannot attack
	aux.EnableCannotAttack(c)
	--slayer
	aux.EnableSlayer(c)
end
