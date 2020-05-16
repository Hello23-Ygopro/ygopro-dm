--Overwritten Group functions
--select a specified card from a group
--Note: Shields are selected at random for abilities that select either player's shields
local group_filter_select=Group.FilterSelect
function Group.FilterSelect(g,player,f,min,max,ex,...)
	--check for "Whenever you would choose one of your opponent's shields, your opponent chooses instead."
	if g:IsExists(aux.AND(aux.ShieldZoneFilter(Card.IsControler),f),1,nil,1-player)
		and Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER) then
		player=1-player
	end
	--Note: Remove this if YGOPro can forbid players to look at their face-down cards
	local sg1=g:Filter(aux.ShieldZoneFilter(f),ex,...)
	local sg2=Group.CreateGroup()
	for c in aux.Next(sg1) do
		if c:IsControler(player) then sg2:AddCard(c) end
	end
	if sg2:GetCount()>0 then
		return sg2:RandomSelect(player,min,max)
	else
		if not g:IsExists(f,1,ex,...) then
			Duel.Hint(HINT_MESSAGE,player,ERROR_NOTARGETS)
		end
		return group_filter_select(g,player,f,min,max,ex,...)
	end
end
--select a card from a group
--Note: Shields are selected at random for abilities that select either player's shields
local group_select=Group.Select
function Group.Select(g,player,min,max,ex)
	--check for "Whenever you would choose one of your opponent's shields, your opponent chooses instead."
	if g:IsExists(aux.ShieldZoneFilter(Card.IsControler),1,nil,1-player)
		and Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER) then
		player=1-player
	end
	--Note: Remove this if YGOPro can forbid players to look at their face-down cards
	local sg1=g:Filter(aux.ShieldZoneFilter(),ex)
	local sg2=Group.CreateGroup()
	for c in aux.Next(sg1) do
		if c:IsControler(player) then sg2:AddCard(c) end
	end
	if sg2:GetCount()>0 then
		return sg2:RandomSelect(player,min,max)
	else
		if g:GetCount()==0 then
			Duel.Hint(HINT_MESSAGE,player,ERROR_NOTARGETS)
		end
		return group_select(g,player,min,max,ex)
	end
end
--select a number of cards from a group at random
--Note: Overwritten to allow selecting up to N cards
--Remove parameter max if YGOPro can forbid players to look at their face-down cards
local group_random_select=Group.RandomSelect
function Group.RandomSelect(g,player,min,max)
	--check for "Whenever you would choose one of your opponent's shields, your opponent chooses instead."
	if g:IsExists(aux.ShieldZoneFilter(Card.IsControler),1,nil,1-player)
		and Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER) then
		player=1-player
	end
	local ct=g:GetCount()
	if ct>0 then
		if min==0 and not Duel.SelectYesNo(player,YESNOMSG_CHOOSE) then return Group.CreateGroup() end
		if max and max>min then
			if ct>max then ct=max end
			local t={}
			for i=1,ct do t[i]=i end
			Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCECHOOSE)
			min=Duel.AnnounceNumber(player,table.unpack(t))
		end
	else
		Duel.Hint(HINT_MESSAGE,player,ERROR_NOTARGETS)
	end
	return group_random_select(g,player,min,max)
end
