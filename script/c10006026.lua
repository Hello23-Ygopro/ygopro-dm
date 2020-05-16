--Razorpine Tree
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STARLIGHT_TREE)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1)
end
--power up
function scard.val1(e,c)
	return Duel.GetShieldCount(c:GetControler())*2000
end
