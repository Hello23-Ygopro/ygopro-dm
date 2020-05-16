--骨折人形トロンボ
--Trombo, Fractured Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (return)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,nil,aux.WaveStrikerCondition)
end
--wave striker (return)
function scard.retfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.DMGraveFilter(scard.retfilter),LOCATION_GRAVE,0)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.DMGraveFilter(Card.IsCreature),LOCATION_GRAVE,0,1)
