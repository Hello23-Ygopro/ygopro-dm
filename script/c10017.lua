--カンナビス
--Cannabis
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SEA_HACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.EnableCannotAttack(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_DESTROYED,nil,nil,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local os=require('os')
	math.randomseed(os.time())
	local ct=math.random(0,3)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
