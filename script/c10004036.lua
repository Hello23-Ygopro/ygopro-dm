--Shadow Moon, Cursed Shade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GHOST)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,LOCATION_BZONE,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_DARKNESS))
end
