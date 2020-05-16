--雷炎賢者エイジス
--Aegis, Sage of Fire and Lightning
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR,RACE_ARMORED_WYVERN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--destroy
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,scard.tg1,scard.op1,nil,scard.con1)
end
--destroy
scard.con1=aux.AND(aux.SelfBlockCondition,aux.SelfBattleWinCondition)
function scard.desfilter(c,race)
	return c:IsFaceup() and c:DMIsRace(race)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	e:SetLabel(bc:DMGetRace())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.desfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,e:GetLabel())
	Duel.Destroy(g,REASON_EFFECT)
end
