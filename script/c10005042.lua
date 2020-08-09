--Kip Chippotto
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--saver (armored dragon)
	aux.AddReplaceEffectDestroy(c,0,scard.tg1,scard.op1,scard.val1)
end
--saver (armored dragon)
function scard.savefilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:DMIsRace(RACE_ARMORED_DRAGON)
		and c:IsControler(tp) and not c:IsReason(REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:FilterCount(scard.savefilter,c,tp)==1 and c:IsDestructable(e) end
	return Duel.SelectYesNo(tp,aux.Stringid(sid,1))
end
function scard.val1(e,c)
	return scard.savefilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
--[[
	Rulings
	Q: If my opponent attacks one of my Armored Dragons and wins, can I still save it with Kip Chippotto?
		A: No, that is not destroyed but rather lost a battle.
	Q: Can I save a creature with 0000+ power from being destroyed?
		A: No, using Kip Chipotto's destruction substitution ability will not prevent the Dragon from being destroyed due
		to a game rule that states that creatures with power 0 or less are destroyed.
	https://duelmasters.fandom.com/wiki/Kip_Chippotto/Rulings
]]
