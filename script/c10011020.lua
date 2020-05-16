--Revival Soldier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (power up)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.EnableUpdatePower(c,4000,aux.WaveStrikerCondition)
	aux.AddEffectDescription(c,2,aux.WaveStrikerCondition)
	--wave striker (destroy replace - return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1,aux.WaveStrikerCondition)
end
--wave striker (destroy replace - return)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
