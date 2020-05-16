--Battleship Mutant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,aux.CheckCardFunction(scard.abfilter,LOCATION_BZONE,0),scard.op1)
end
--tap ability (get ability)
function scard.abfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_DARKNESS)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.abfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,2,4000)
		--double breaker
		aux.AddTempEffectBreaker(c,tc,3,EFFECT_DOUBLE_BREAKER)
		--destroy
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,1))
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_ATTACK_END)
		e1:SetCondition(aux.SelfBattleEndCondition)
		e1:SetOperation(aux.SelfBattleEndOperation)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
