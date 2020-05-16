--Klujadras
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--wave striker (draw)
	aux.EnableWaveStriker(c)
	aux.AddEffectDescription(c,1,aux.WaveStrikerCondition)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.WaveStrikerCondition)
end
--wave striker (draw)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_WAVE_STRIKER)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(scard.cfilter,tp,LOCATION_BZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(scard.cfilter,tp,0,LOCATION_BZONE,nil)
	Duel.Draw(tp,ct1,REASON_EFFECT)
	Duel.Draw(1-tp,ct2,REASON_EFFECT)
end
