--Jagila, the Hidden Pillager
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PANDORAS_BOX)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (discard)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.WaveStrikerCondition)
end
--wave striker (discard)
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,3,3,true)
