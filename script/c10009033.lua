--Trixo, Wicked Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--destroy
scard.con1=aux.AND(aux.UnblockedCondition,aux.AttackPlayerCondition)
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
