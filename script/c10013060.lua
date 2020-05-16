--無双恐皇ガラムタ
--Galamuta, Matchless Fear Lord
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD,RACE_EARTH_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--sympathy (death puppet, beast folk)
	aux.EnableSympathy(c,RACE_DEATH_PUPPET,RACE_BEAST_FOLK)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--cannot use shield trigger
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,1)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--cannot use shield trigger
function scard.val1(e,re,tp)
	return re:IsHasCategory(CATEGORY_SHIELD_TRIGGER)
end
