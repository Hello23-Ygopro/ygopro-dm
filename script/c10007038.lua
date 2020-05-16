--Cratersaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c,nil,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_SELF))
	--power attacker
	aux.EnablePowerAttacker(c,3000,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoShieldsCondition(PLAYER_SELF))
end
