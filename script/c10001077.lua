--Fatal Attacker Horvath
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.AND(aux.SelfAttackerCondition,aux.ExistingCardCondition(scard.cfilter)))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:DMIsRace(RACE_ARMORLOID)
end
