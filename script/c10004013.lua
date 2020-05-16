--Mist Rias, Sonic Guardian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GUARDIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsFaceup,1,e:GetHandler())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
--[[
	Rulings
		Q: I summon Chaos Worm, which says, "When you put this creature into the battle zone, you may destroy one of your
		opponent's creatures." I destroy my opponent's Mist Rias. Does my opponent get to draw a card?
		A: Yes. When you put Chaos Worm into the battle zone, its ability and Mist Rias's ability both trigger. Your Chaos
		Worm's effect happens first because it's your turn, and Mist Rias is destroyed. Mist Rias's effect still happens,
		though. Mist Rias saw Chaos Worm enter the battle zone, so your opponent gets to draw a card.
		https://duelmasters.fandom.com/wiki/Mist_Rias,_Sonic_Guardian/Rulings
]]
