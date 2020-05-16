--Cutthroat Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--speed attacker
	aux.EnableEffectCustom(c,EFFECT_SPEED_ATTACKER)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--return
	aux.EnableTurnEndSelfReturn(c)
end
