--Gnarvash, Merchant of Blood
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEMON_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--destroy
	aux.EnableTurnEndSelfDestroy(c,0,scard.con1)
end
--destroy
function scard.con1(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_BZONE,0)==1
end
