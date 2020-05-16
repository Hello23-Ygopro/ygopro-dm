--Mana Bonanza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetManaCount(tp)
	Duel.SendDecktoptoMZone(tp,ct,POS_FACEUP_TAPPED,REASON_EFFECT)
end
