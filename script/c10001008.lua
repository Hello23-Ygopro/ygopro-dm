--Iocant, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_ANGEL_COMMAND)
end
