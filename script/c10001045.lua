--Black Feather, Shadow of Rage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1))
end
