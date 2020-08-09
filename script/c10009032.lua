--Slash Charger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--search (to grave)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
	--charger
	aux.EnableEffectCustom(c,EFFECT_CHARGER)
end
--search (to grave)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	if g1:GetCount()==0 and g2:GetCount()==0 then return end
	local option_list={}
	local t={}
	if g1:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if g2:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local g=(opt==1 and g1) or (opt==2 and g2)
	local p=(opt==1 and tp) or (opt==2 and 1-tp)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:Select(tp,0,1,nil)
	if sg:GetCount()>0 then
		Duel.DMSendtoGrave(sg,REASON_EFFECT)
	else Duel.ShuffleDeck(p) end
end
--[[
	References
	* Mooyan Curry
	https://github.com/Fluorohydride/ygopro-scripts/blob/master/c58074572.lua
]]
