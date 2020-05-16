--Aqua Agent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIQUID_PEOPLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--stealth (water)
	aux.EnableStealth(c,CIVILIZATION_WATER)
	--destroy replace (return)
	aux.AddSingleReplaceEffectDestroy(c,0,scard.tg1,scard.op1)
end
--destroy replace (return)
scard.tg1=aux.SingleReplaceDestroyTarget2(1,Card.IsAbleToHand)
scard.op1=aux.SingleReplaceDestroyOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
