--Cannon Shell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_COLONY_BEETLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
end
--power up
function scard.val1(e,c)
	return Duel.GetShieldCount(c:GetControler())*1000
end
