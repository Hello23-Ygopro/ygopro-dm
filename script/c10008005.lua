--Kachua, Keeper of the Icegate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap ability (search - to battle zone)
	aux.EnableTapAbility(c,0,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--tap ability (search - to battle zone)
function scard.tbfilter(c,e,tp)
	return c:IsRaceCategory(RACECAT_DRAGON) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp):GetFirst()
	if not tc or not Duel.SendtoBZoneStep(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED) then return end
	local c=e:GetHandler()
	--speed attacker
	aux.AddTempEffectCustom(c,tc,2,EFFECT_SPEED_ATTACKER)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	Duel.SendtoBZoneComplete()
end
--destroy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsDestructable() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Destroy(c,REASON_EFFECT)
end
--[[
	Rulings
	Q: I use Kachua's ability to search for an evolution creature that has Dragon in its race, but I don't have a
	creature it can evolve from in the battle zone. What happens?
		A: An evolution creature can't exist in the battle zone unless it's on top of another creature. You cannot even
		try to put the evolution creature into the battle zone if you do not have a correct base creature to evolve from.
	https://duelmasters.fandom.com/wiki/Kachua,_Keeper_of_the_Icegate/Rulings
]]
