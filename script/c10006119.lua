--Cliffcrush Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--cannot attack
function scard.cfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
