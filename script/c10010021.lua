--Messa Bahna, Expanse Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--must block
	aux.EnableEffectCustom(c,EFFECT_MUST_BLOCK)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
