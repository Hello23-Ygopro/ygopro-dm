--Glory Snow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield trigger
	aux.EnableShieldTrigger(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetManaCount(1-tp)>Duel.GetManaCount(tp) then
		Duel.SendDecktoptoMZone(tp,2,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
