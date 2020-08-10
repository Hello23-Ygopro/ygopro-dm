--Gigamantis
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GIANT_INSECT)
	aux.AddEvolutionRaceList(c,RACE_GIANT_INSECT,RACE_GIANT)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_GIANT_INSECT))
	--destroy replace (to mana zone)
	aux.AddReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.val1)
end
--destroy replace (to mana zone)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:IsCivilization(CIVILIZATION_NATURE)
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE) and c:IsAbleToMZone()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(scard.repfilter,1,c,tp) end
	local g=eg:Filter(scard.repfilter,c,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoMZone(e:GetLabelObject(),POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
end
