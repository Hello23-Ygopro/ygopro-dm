--反撃妖精ポコペン
--Pocopen, Counterattacking Faerie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_BE_BATTLE_TARGET,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to grave
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.ManaZoneFilter(Card.DMIsAbleToGrave),0,LOCATION_MZONE,1,1,HINTMSG_TOGRAVE)
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
