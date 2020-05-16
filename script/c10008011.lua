--Nariel, the Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIGHT_BRINGER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsPowerAbove,3000))
end
