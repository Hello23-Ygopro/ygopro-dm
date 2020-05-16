--Kalute, Vizier of Eternity
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy replace (return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.con1)
end
--destroy replace (return)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCode(sid)
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,LOCATION_BZONE,1,e:GetHandler())
end
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
