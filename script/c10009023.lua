--Tekorax
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.ConfirmOperation(nil,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE))
end
