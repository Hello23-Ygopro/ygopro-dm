--Arc Bine, the Astounding
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GUARDIAN))
	--get ability (tap ability - tap)
	aux.AddStaticEffectTapAbility(c,0,scard.tg1,scard.op1,LOCATION_BZONE,0,scard.tg2,EFFECT_FLAG_CARD_TARGET)
end
scard.evolution_race_list={RACE_GUARDIAN}
--get ability (tap ability - tap)
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.posfilter,tp,0,LOCATION_BZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
scard.tg2=aux.TargetBoolFunction(Card.IsCivilization,CIVILIZATION_LIGHT)
