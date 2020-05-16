--Onslaughter Triceps
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoGraveOperation(PLAYER_SELF,aux.ManaZoneFilter(),LOCATION_MZONE,0,1))
end
