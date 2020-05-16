--剣撃士ザック・ランバー
--Zack Ranba, the Sword Attacker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAGO_NOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.MZoneExclusiveCondition(Card.IsTapped))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsTapped))
end
