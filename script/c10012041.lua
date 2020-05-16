--Funky Wizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MERFOLK)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.draw(tp)
	scard.draw(1-tp)
end
function scard.draw(tp)
	if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
