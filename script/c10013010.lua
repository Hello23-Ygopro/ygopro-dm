--死皇帝ベルセバ
--Belzeber, Emperor of Death
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	aux.AddEvolutionRaceList(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DARK_LORD))
	--to grave
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
--to grave
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsFaceup,1,e:GetHandler())
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local p=eg:GetFirst():GetOwner()
	local f=aux.ManaZoneFilter(Card.DMIsAbleToGrave)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(p) and f(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
	Duel.SelectTarget(p,f,p,LOCATION_MZONE,0,1,1,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
