--電磁霊樹アカシック・セカンド
--Akashic Second, Electro-Spirit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_MYSTERY_TOTEM)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
	--destroy replace (to mana zone)
	aux.AddSingleReplaceEffectDestroy(c,1,scard.tg1,scard.op1)
end
--destroy replace (to mana zone)
scard.tg1=aux.SingleReplaceDestroyTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
