--聖霊龍騎アサイラム
--Asylum, the Dragon Paladin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (angel command, armored dragon)
	aux.EnableSympathy(c,RACE_ANGEL_COMMAND,RACE_ARMORED_DRAGON)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy replace (to shield zone)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (to shield zone)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToSZone)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoSZone)
