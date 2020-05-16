--Mongrel Man
--Not fully implemented: If this and another creature are destroyed at the same time, you can still trigger its ability.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_DESTROYED,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCreature,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
--[[
	Rulings
		Q: This creature and other creatures are destroyed at the same time (by a card such as Vampire Silphy). How many
		cards can I draw?
		A: You can draw a card for each other creature that's destroyed (just not for Mongrel Man itself).
		https://duelmasters.fandom.com/wiki/Mongrel_Man/Rulings
]]
