--Bex, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_SELF))
end
