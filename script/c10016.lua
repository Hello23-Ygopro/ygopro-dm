--沈黙の使徒カザミラ
--Kazamira, Vizier of Silence
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INITIATE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoSZoneOperation(PLAYER_ALL,2))
end
