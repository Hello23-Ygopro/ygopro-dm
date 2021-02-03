--Sphere of Wonder
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to shield zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetShieldCount(1-tp)>Duel.GetShieldCount(tp) then
		Duel.SendDecktoSZone(tp,1)
	end
end
