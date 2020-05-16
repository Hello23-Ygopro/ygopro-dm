--Gigagrax
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,true,scard.tg1,scard.op1)
end
--destroy
scard.tg1=aux.CheckCardFunction(Card.IsFaceup,0,LOCATION_BZONE)
scard.op1=aux.DestroyOperation(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1)
