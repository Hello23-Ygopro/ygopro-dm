--Soul Phoenix, Avatar of Unity
--[[
	Not fully implemented:
		1. The effect of Soul Phoenix leaving the battle zone is not substituted or replaced
		It should not be treated as being destroyed by effects that destroy it (same for any other removal effect)
		2. The effect of Soul Phoenix leaving the battle zone is not applied when it is added to the shield zone
]]
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PHOENIX)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter1,scard.evofilter2)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--leave replace (separate evolution source)
	aux.AddSingleReplaceEffectLeaveBZone(c,0,scard.op1)
end
scard.evolution_race_list={RACE_FIRE_BIRD,RACE_EARTH_DRAGON}
scard.evolution_race_cat_list={RACECAT_DRAGON}
--vortex evolution
scard.evofilter1=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_FIRE_BIRD)
scard.evofilter2=aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_EARTH_DRAGON)
--leave replace (separate evolution source)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local mg=c:GetEvolutionSourceGroup()
	local pos=c:GetPreviousPosition()
	local g=Group.CreateGroup()
	g:Merge(mg)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	for tc in aux.Next(g) do
		Duel.MoveToField(tc,tp,tp,LOCATION_BZONE,pos,true)
	end
end
