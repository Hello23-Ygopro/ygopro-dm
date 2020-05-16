--我狼兵ラングレン
--Langren, the Lone Wolf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--cannot attack
function scard.cfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,LOCATION_BZONE,1,e:GetHandler())
end
