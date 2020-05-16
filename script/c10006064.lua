--Lupa, Poison-Tipped Doll
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DEATH_PUPPET)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (get ability)
	aux.EnableTapAbility(c,0,nil,scard.op1)
end
--tap ability (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--slayer
	aux.AddTempEffectSlayer(e:GetHandler(),g:GetFirst(),1)
end
