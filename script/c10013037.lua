--結界の守護者クレス・ドーベル
--Creis Dober, Barrier Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--get ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--get ability
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()==e:GetHandler() and re:IsHasCategory(CATEGORY_BLOCKER)
		and Duel.IsExistingMatchingCard(scard.cfilter,tp,0,LOCATION_BZONE,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,4000,0,0)
end
