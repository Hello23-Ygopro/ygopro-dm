--爛漫妖精フリップル
--Flipull, Full Bloom Faerie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--to mana zone
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsAbleToMZone()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tmfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil):RandomSelect(tp,1)
	Duel.HintSelection(g)
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
