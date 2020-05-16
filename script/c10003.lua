--煉獄の影トワイライト・テラー
--Twilight Terror, Shadow of Purgatory
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--wins all battles (guardian)
	aux.EnableWinsAllBattles(c,0,aux.FilterBoolFunction(Card.DMIsRace,RACE_GUARDIAN))
	--discard
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
