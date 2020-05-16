--電磁旋竜アカシック・ファースト
--Akashic First, Electro-Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_VOLCANO_DRAGON)
	aux.AddRaceCategory(c,RACECAT_CYBER,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (cyber virus, dragonoid)
	aux.EnableSympathy(c,RACE_CYBER_VIRUS,RACE_DRAGO_NOID)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--destroy replace (return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (return)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
