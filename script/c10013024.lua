--照準野郎ジルバ
--Lockon Dude Jiruba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--silent skill (get ability)
	aux.EnableSilentSkill(c,0,nil,scard.op1)
end
--silent skill (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,e:GetHandler())
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--attack untapped
		aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_ATTACK_UNTAPPED)
	end
end
