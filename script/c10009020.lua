--Kelp Candle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	aux.AddRaceCategory(c,RACECAT_CYBER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.EnableCannotAttack(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,nil,nil,scard.op1)
end
--to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,4)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(Card.IsAbleToHand,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		aux.SortDeck(tp,tp,3,SEQ_DECK_BOTTOM)
	else aux.SortDeck(tp,tp,4,SEQ_DECK_BOTTOM) end
end
--[[
	References
	* Dark Magical Circle
	https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c47222536.lua#L38
	* World Legacy Survivor
	https://github.com/Fluorohydride/ygopro-scripts/blob/97e53fe/c31706048.lua#L24
]]
