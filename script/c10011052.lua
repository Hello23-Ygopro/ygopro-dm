--Live and Breathe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--search (to battle zone)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_COME_INTO_PLAY)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(aux.PlayerSummonCreatureCondition(PLAYER_SELF))
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--search (to battle zone)
function scard.tbfilter(c,e,tp,code)
	return c:IsCreature() and c:IsCode(code) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local code=eg:GetFirst():GetCode()
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp,code)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local sg=g:Select(tp,0,1,nil)
	if sg:GetCount()==0 then return end
	Duel.SendtoBZone(sg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
--[[
	Rulings
		* Live and Breathe's effect does not trigger itself, as putting a creature into the battle zone with its effect
		is not summoning.
		https://duelmasters.fandom.com/wiki/Live_and_Breathe/Rulings
]]
