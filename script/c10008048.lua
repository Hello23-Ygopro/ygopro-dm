--Coliseum Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,true,scard.tg1,scard.op1)
end
--to mana zone
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
