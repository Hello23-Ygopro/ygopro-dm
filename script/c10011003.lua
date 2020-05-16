--Diamondia, the Blizzard Rider
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SNOW_FAERIE))
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
scard.evolution_race_list={RACE_SNOW_FAERIE}
--return
function scard.retfilter(c)
	return c:DMIsRace(RACE_SNOW_FAERIE) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.DMGraveFilter(scard.retfilter),tp,LOCATION_GRAVE,0,nil)
	local g2=Duel.GetMatchingGroup(aux.ManaZoneFilter(scard.retfilter),tp,LOCATION_MZONE,0,nil)
	g1:Merge(g2)
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
