--Skullcutter, Swarm Leader
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEVIL_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--destroy
	aux.EnableTurnEndSelfDestroy(c,0,scard.con1)
end
--destroy
function scard.con1(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_BZONE,0)==1
end
