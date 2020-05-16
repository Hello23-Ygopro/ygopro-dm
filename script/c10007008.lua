--Justice Jamming
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--tap
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--tap
function scard.posfilter(c,civ)
	return c:IsFaceup() and c:IsCivilization(civ) and c:IsAbleToTap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,CIVILIZATION_DARKNESS)
	local g2=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,LOCATION_BZONE,nil,CIVILIZATION_FIRE)
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
	Duel.Tap(g,REASON_EFFECT)
end
