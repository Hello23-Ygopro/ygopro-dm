--Pippie Kuppie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,1000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunction(Card.DMIsRace,RACE_ARMORED_DRAGON))
end
