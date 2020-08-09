--Simian Warrior Grash
--Not fully implemented: If this and another creature are destroyed at the same time, you can still trigger its ability.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORLOID)
	--creature
	aux.EnableCreatureAttribute(c)
	--to grave
	aux.AddTriggerEffect(c,0,EVENT_DESTROYED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to grave
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.DMIsPreviousRace,1,nil,RACE_ARMORLOID)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.ManaZoneFilter(Card.DMIsAbleToGrave)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and f(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	Duel.SelectTarget(1-tp,f,1-tp,LOCATION_MZONE,0,eg:GetCount(),eg:GetCount(),nil)
end
scard.op1=aux.TargetCardsOperation(Duel.DMSendtoGrave,REASON_EFFECT)
--[[
	References
	* Performapal Sellshell Crab
	https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c23377694.lua#L68
]]
