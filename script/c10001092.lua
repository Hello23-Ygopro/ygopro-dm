--Coiling Vines
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy replace (to mana zone)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (to mana zone)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
