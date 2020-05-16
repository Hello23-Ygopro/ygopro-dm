--Gigazoul
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,aux.NoShieldsCondition(PLAYER_OPPO))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_OPPO))
end
