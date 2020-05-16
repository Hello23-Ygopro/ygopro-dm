--Hearty Cap'n Polligon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_FAERIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.EnableTurnEndSelfReturn(c,0,scard.con1)
end
--return
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBrokenShieldCount()>0 and Duel.GetTurnPlayer()==tp
end
