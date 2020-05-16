--Storm Wrangler, the Furious
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_FOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_BEAST_FOLK))
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--get ability
	aux.AddSingleTriggerEffect(c,1,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,nil,nil,scard.op2)
end
scard.evolution_race_list={RACE_BEAST_FOLK}
--get ability
function scard.abfilter(c)
	return c:IsFaceup() and c:IsUntapped() and c:IsHasEffect(EFFECT_BLOCKER)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.abfilter,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not scard.abfilter(tc) then return end
	--must block
	aux.AddTempEffectCustom(e:GetHandler(),tc,2,EFFECT_MUST_BLOCK)
	--raise event to trigger "Blocker"
	Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_TRIGGER_BLOCKER,e,0,0,0,0)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,3,3000)
end
