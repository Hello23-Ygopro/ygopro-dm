--Marrow Ooze, the Twister
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_DEAD)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_ATTACK_PLAYER,nil,nil,aux.SelfDestroyOperation())
end
