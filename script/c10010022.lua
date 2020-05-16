--Pala Olesis, Morning Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.TurnPlayerCondition(PLAYER_OPPO),LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
end
