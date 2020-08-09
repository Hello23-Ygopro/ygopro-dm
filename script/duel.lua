--Fix missing Duel function errors
local duel_attack_cost_paid=Duel.AttackCostPaid
function Duel.AttackCostPaid()
	if duel_attack_cost_paid then return duel_attack_cost_paid() end
	return nil
end
--Overwritten Duel functions
--send a card to a player's hand
--Note: Added parameter use_shield_trigger to allow a player to use the "shield trigger" ability of a returned shield
local duel_send_to_hand=Duel.SendtoHand
function Duel.SendtoHand(targets,player,reason,use_shield_trigger)
	--use_shield_trigger: true if player can use the "shield trigger" ability of the returned shield
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc1 in aux.Next(targets) do
		local g=tc1:GetEvolutionSourceGroup()
		if tc1:IsCanEvolutionSourceLeave() then targets:Merge(g) end
	end
	local res=duel_send_to_hand(targets,player,reason,use_shield_trigger)
	for tc2 in aux.Next(targets) do
		if use_shield_trigger then
			--raise event for "Shield Trigger"
			Duel.RaiseSingleEvent(tc2,EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_TRIGGER,Effect.GlobalEffect(),0,0,0,0)
		end
	end
	return res
end
--send a card to a player's deck
--Note: Overwritten to send a card's evolution source to the deck
local duel_send_to_deck=Duel.SendtoDeck
function Duel.SendtoDeck(targets,player,seq,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		local g=tc:GetEvolutionSourceGroup()
		if tc:IsCanEvolutionSourceLeave() then targets:Merge(g) end
	end
	local res=duel_send_to_deck(targets,player,seq,reason)
	if seq==SEQ_DECK_TOP or seq==SEQ_DECK_BOTTOM then
		local dct1=Duel.GetOperatedGroup():FilterCount(Card.IsControler,nil,0)
		local dct2=Duel.GetOperatedGroup():FilterCount(Card.IsControler,nil,1)
		if dct1>1 then
			Duel.SortDecktop(player,0,dct1)
			if seq==SEQ_DECK_BOTTOM then
				for i=1,dct1 do
					local mg=Duel.GetDecktopGroup(PLAYER_ONE,1)
					Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
				end
			end
		end
		if dct2>1 then
			Duel.SortDecktop(player,1,dct2)
			if seq==SEQ_DECK_BOTTOM then
				for i=1,dct2 do
					local mg=Duel.GetDecktopGroup(PLAYER_TWO,1)
					Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
				end
			end
		end
	end
	return res
end
--send a card to the battle zone
--Note: Overwritten to notify a player if all zones are occupied
local duel_special_summon_step=Duel.SpecialSummonStep
function Duel.SpecialSummonStep(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
	if Duel.GetLocationCount(target_player,LOCATION_BZONE)==0 then
		Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		return false
	end
	return duel_special_summon_step(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
end
Duel.SendtoBZoneStep=Duel.SpecialSummonStep
local duel_special_summon=Duel.SpecialSummon
function Duel.SpecialSummon(targets,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	zone=zone or ZONE_MZONE
	local res=0
	for tc in aux.Next(targets) do
		if Duel.GetLocationCount(target_player,LOCATION_BZONE)>0 then
			--check for "This creature is put into the battle zone tapped."
			if tc:IsHasEffect(EFFECT_ENTER_BZONE_TAPPED) then pos=POS_FACEUP_TAPPED end
			--check for an evolution creature
			if tc:IsEvolution() then
				Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_EVOLUTION_TO_BZONE,Effect.GlobalEffect(),0,0,0,0)
			end
			if Duel.SpecialSummonStep(tc,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone) then
				res=res+1
			end
		else
			Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		end
	end
	Duel.SpecialSummonComplete()
	return res
end
Duel.SendtoBZone=Duel.SpecialSummon
Duel.SendtoBZoneComplete=Duel.SpecialSummonComplete
--change the position of a card
--Note: Added parameter reason (not fully implemented)
local duel_change_position=Duel.ChangePosition
function Duel.ChangePosition(targets,pos,reason)
	reason=reason or REASON_EFFECT
	return duel_change_position(targets,pos,reason)
end
--show a player a card
--Note: Added parameter turn_faceup to keep a shield face up
local duel_confirm_cards=Duel.ConfirmCards
function Duel.ConfirmCards(player,targets,turn_faceup)
	--turn_faceup: true to keep the revealed shield face up
	if turn_faceup then
		Duel.TurnShield(targets,POS_FACEUP)
	else
		return duel_confirm_cards(player,targets,turn_faceup)
	end
end
--draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_draw(player,count,reason)
end
--check if a player can draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	count=count or 0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_is_player_can_draw(player,count)
end
--discard a card
--Note: Overwritten to banish a discarded card
function Duel.DiscardHand(player,f,min,max,reason,ex,...)
	max=max or min
	reason=reason or REASON_EFFECT
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(player,f,player,LOCATION_HAND,0,min,max,ex,...)
	if g:GetCount()==0 then return 0 end
	return Duel.Remove(g,POS_FACEUP,reason+REASON_DISCARD)
end
--select a card
--Note: Shields are selected at random for abilities that select either player's shields
local duel_select_matching_card=Duel.SelectMatchingCard
function Duel.SelectMatchingCard(sel_player,f,player,s,o,min,max,ex,...)
	--check for "Whenever you would choose one of your opponent's shields, your opponent chooses instead."
	if sel_player==player and o==LOCATION_SZONE
		and Duel.IsPlayerAffectedByEffect(1-sel_player,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER) then
		sel_player=1-sel_player
	end
	if sel_player==player and s==LOCATION_SZONE then
		--Note: Remove this if YGOPro can forbid players to look at their face-down cards
		local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(f),player,s,o,ex,...)
		return g:RandomSelect(sel_player,min,max)
	else
		if not Duel.IsExistingMatchingCard(f,player,s,o,1,ex,...) then
			Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
		end
		return duel_select_matching_card(sel_player,f,player,s,o,min,max,ex,...)
	end
end
--target a card
--Note: Shields are selected at random for abilities that select either player's shields
local duel_select_target=Duel.SelectTarget
function Duel.SelectTarget(sel_player,f,player,s,o,min,max,ex,...)
	--check for "Whenever you would choose one of your opponent's shields, your opponent chooses instead."
	if sel_player==player and o==LOCATION_SZONE
		and Duel.IsPlayerAffectedByEffect(1-sel_player,EFFECT_CHANGE_SHIELD_CHOOSE_PLAYER) then
		sel_player=1-sel_player
	end
	if sel_player==player and s==LOCATION_SZONE then
		--Note: Remove this if YGOPro can forbid players to look at their face-down cards
		local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(f),player,s,o,ex,...)
		local sg=g:RandomSelect(sel_player,min,max)
		Duel.SetTargetCard(sg)
		return sg
	else
		if not Duel.IsExistingTarget(f,player,s,o,1,ex,...) then
			Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
		end
		return duel_select_target(sel_player,f,player,s,o,min,max,ex,...)
	end
end
--New Duel functions
--tap a card
function Duel.Tap(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToTap() then
			if tc:IsLocation(LOCATION_BZONE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_TAPPED,reason)
			elseif tc:IsLocation(LOCATION_MZONEUNT) then
				res=res+Duel.Remove(tc,POS_FACEDOWN,reason)
				Duel.RaiseSingleEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
				Duel.RaiseEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
			end
		end
	end
	return res
end
--untap a card
function Duel.Untap(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToUntap() then
			if tc:IsLocation(LOCATION_BZONE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_UNTAPPED,reason)
			elseif tc:IsLocation(LOCATION_MZONETAP) then
				res=res+Duel.SendtoGrave(tc,reason)
				Duel.RaiseSingleEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
				Duel.RaiseEvent(tc,EVENT_CHANGE_POS,Effect.GlobalEffect(),reason,0,0,0)
			end
		end
	end
	return res
end
--tap a card in the mana zone to summon a creature or to cast a spell
function Duel.PayManaCost(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		res=res+Duel.Tap(targets,REASON_COST)
	end
	return res
end
--turn a shield face up or down
function Duel.TurnShield(targets,pos)
	--pos: POS_FACEUP to turn face up or POS_FACEDOWN to turn face down
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		res=res+Duel.ChangePosition(tc,pos)
	end
	return res
end
--break a shield
--Note: Update this function if a new "breaker" ability is introduced
--Not yet implemented: Quattro, world, galaxy, infinity, civilization, age, master
function Duel.BreakShield(e,sel_player,target_player,count,rc,reason,ignore_breaker)
	--sel_player: the player who selects the shield to break
	--target_player: the player whose shield to break
	--count: the number of shields to break
	--rc: the creature that breaks the shield
	--reason: the reason for breaking the shield (REASON_EFFECT by default)
	--ignore_breaker: true to not break a number of shields according to the breaker abilities a creature may have
	--check for "Whenever an opponent's creature would break a shield, you choose the shield instead of your opponent."
	if sel_player~=target_player and rc:IsCreature()
		and Duel.IsPlayerAffectedByEffect(target_player,EFFECT_CHANGE_SHIELD_BREAK_PLAYER) then
		sel_player=target_player
	end
	reason=reason or REASON_EFFECT
	Duel.Tap(rc,REASON_RULE) --fix creature not being tapped when attacking
	local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(),target_player,LOCATION_SZONE,0,nil)
	if g:GetCount()==0 or not rc:IsCanBreakShield() then return 0 end
	if rc and not ignore_breaker then
		--check for "Breaker" keywords
		local db=rc:IsHasEffect(EFFECT_DOUBLE_BREAKER)
		local tb=rc:IsHasEffect(EFFECT_TRIPLE_BREAKER)
		local cb=rc:IsHasEffect(EFFECT_CREW_BREAKER)
		if rc:GetEffectCount(EFFECT_BREAKER)==1 then
			if db then count=2
			elseif tb then count=3
			elseif cb then count=aux.GetCrewBreakerCount(rc) end
		elseif rc:GetEffectCount(EFFECT_BREAKER)>1 then
			local available_list={}
			if db then table.insert(available_list,1) end
			if tb then table.insert(available_list,2) end
			if cb then table.insert(available_list,3) end
			local option_list={}
			for _,te in pairs(available_list) do
				table.insert(option_list,aux.break_select_list[te])
			end
			Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_APPLYABILITY)
			local opt=Duel.SelectOption(sel_player,table.unpack(option_list))+1
			if opt==1 then count=2
			elseif opt==2 then count=3
			elseif opt==3 then count=aux.GetCrewBreakerCount(rc) end
		end
		--check for "breaks one more shield"
		if rc:IsHasEffect(EFFECT_BREAK_EXTRA_SHIELD) then
			count=count+rc:GetEffectCount(EFFECT_BREAK_EXTRA_SHIELD)
		end
	end
	Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_BREAK)
	local sg=g:Select(sel_player,count,count,nil)
	Duel.HintSelection(sg)
	local res=0
	--check for break replace abilities
	local to_grave=nil
	local t={rc:IsHasEffect(EFFECT_BREAK_SHIELD_REPLACE)}
	if #t>0 then
		for _,te in pairs(t) do
			if te:GetValue()==LOCATION_GRAVE then to_grave=true end
		end
		if to_grave then Duel.DMSendtoGrave(sg,reason) end
	else
		--register broken shields
		for sc in aux.Next(sg) do
			--add description
			sc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD-RESET_TOHAND-RESET_LEAVE,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_BROKEN)
			--register Card.IsBrokenShield
			sc:RegisterFlagEffect(EFFECT_BROKEN_SHIELD,RESET_EVENT+RESETS_STANDARD-RESET_TOHAND-RESET_LEAVE,0,1)
			--register Card.GetBrokenShieldCount
			rc:RegisterFlagEffect(EFFECT_BREAK_SHIELD,RESET_PHASE+PHASE_END,0,1)
			--register Duel.GetBrokenShieldCount
			Duel.RegisterFlagEffect(rc:GetControler(),EFFECT_BREAK_SHIELD,RESET_PHASE+PHASE_END,0,1)
		end
		--check for "Your opponent reveals shields broken by your creatures"
		if Duel.IsPlayerAffectedByEffect(1-rc:GetControler(),EFFECT_CONFIRM_BROKEN_SHIELD) then
			Duel.ConfirmCards(rc:GetControler(),sg)
		end
		res=res+Duel.SendtoHand(sg,PLAYER_OWNER,reason+REASON_BREAK)
		local og=Duel.GetOperatedGroup()
		for oc in aux.Next(og) do
			--add message
			if not oc:IsHasEffect(EFFECT_SHIELD_TRIGGER) then Duel.Hint(HINT_MESSAGE,target_player,ERROR_NOSTRIGGER) end
			--raise event for "Shield Trigger"
			Duel.RaiseSingleEvent(oc,EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_TRIGGER,Effect.GlobalEffect(),0,0,0,0)
		end
		local hg=Duel.GetFieldGroup(0,LOCATION_HAND,LOCATION_HAND)
		for hc in aux.Next(hg) do
			--reset Card.IsBrokenShield
			if not og:IsContains(hc) then hc:ResetFlagEffect(EFFECT_BROKEN_SHIELD) end
		end
		--raise event for "Whenever this creature breaks a shield" + re:GetHandler()==e:GetHandler()
		Duel.RaiseEvent(og,EVENT_CUSTOM+EVENT_BREAK_SHIELD,e,0,0,0,0)
	end
	return res
end
aux.break_select_list={
	[1]=DESC_DOUBLE_BREAKER,[2]=DESC_TRIPLE_BREAKER,[3]=DESC_CREW_BREAKER
}
--send a card to the mana zone
function Duel.SendtoMZone(targets,pos,reason,keep_evo_source)
	--pos: POS_FACEUP_UNTAPPED for untapped position or POS_FACEUP_TAPPED for tapped position
	--keep_evo_source: true to prevent evolution source from leaving the battle zone
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--check for multicolored cards
	local g1=targets:Filter(Card.IsMulticolored,nil)
	targets:Sub(g1)
	local res=0
	for tc1 in aux.Next(targets) do
		if tc1:IsAbleToMZone() then
			local g2=tc1:IsCanEvolutionSourceLeave() and tc1:GetEvolutionSourceGroup() or Group.CreateGroup()
			if keep_evo_source then g2=Group.CreateGroup() end
			if pos==POS_FACEUP_UNTAPPED then
				res=res+Duel.SendtoGrave(g2,reason)
				res=res+Duel.SendtoGrave(tc1,reason)
			elseif pos==POS_FACEUP_TAPPED then
				res=res+Duel.Remove(g2,POS_FACEDOWN,reason)
				res=res+Duel.Remove(tc1,POS_FACEDOWN,reason)
			end
		end
	end
	--multicolored cards enter the mana zone tapped
	for tc2 in aux.Next(g1) do
		if tc2:IsAbleToMZone() then
			local g2=tc2:IsCanEvolutionSourceLeave() and tc2:GetEvolutionSourceGroup() or Group.CreateGroup()
			if keep_evo_source then g2=Group.CreateGroup() end
			res=res+Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
		end
	end
	res=res+Duel.Remove(g1,POS_FACEDOWN,REASON_RULE)
	return res
end
--send a card to the graveyard
function Duel.DMSendtoGrave(targets,reason,keep_evo_source)
	--keep_evo_source: true to prevent evolution source from leaving the battle zone
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		local g=tc:GetEvolutionSourceGroup()
		if tc:IsCanEvolutionSourceLeave() and not keep_evo_source then targets:Merge(g) end
		if tc:DMIsAbleToGrave() then
			if tc:IsLocation(LOCATION_MZONETAP) and tc:IsFacedown() then
				--workaround to banish a banished card
				--Note: Remove this if YGOPro can flip a face-down banished card face-up
				if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE+REASON_TEMPORARY)>0 then
					Duel.ConfirmCards(1-tc:GetControler(),tc)
				end
			end
			res=res+Duel.Remove(tc,POS_FACEUP,reason)
		end
	end
	return res
end
--send a card to the shield zone
--Note: Currently does not check if evolution source can leave the battle zone
function Duel.SendtoSZone(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc1 in aux.Next(targets) do
		if tc1:IsAbleToSZone() then
			--send evolution source to shield zone first to prevent the game from removing it
			local g=tc1:GetEvolutionSourceGroup()
			for tc2 in aux.Next(g) do
				if tc2:IsAbleToSZone() then
					--if tc1:IsCanEvolutionSourceLeave() then
						if Duel.GetLocationCount(tc2:GetOwner(),LOCATION_SZONE)>0 then
							if Duel.MoveToField(tc2,tc2:GetOwner(),tc2:GetOwner(),LOCATION_SZONE,POS_FACEDOWN,true) then
								res=res+1
							end
						else
							Duel.Hint(HINT_MESSAGE,tc2:GetOwner(),ERROR_NOSZONES)
						end
					--end
				end
			end
			if Duel.GetLocationCount(tc1:GetOwner(),LOCATION_SZONE)>0 then
				if Duel.MoveToField(tc1,tc1:GetOwner(),tc1:GetOwner(),LOCATION_SZONE,POS_FACEDOWN,true) then
					res=res+1
				end
			else
				Duel.Hint(HINT_MESSAGE,tc1:GetOwner(),ERROR_NOSZONES)
			end
		end
	end
	return res
end
--send a card from the top of a player's deck to the mana zone
function Duel.SendDecktoptoMZone(player,count,pos,reason)
	--player: the player whose cards to send to the mana zone
	--count: the number of cards to send to the mana zone
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.SendtoMZone(g,pos,reason)
end
--send a card from the top of a player's deck to the graveyard
function Duel.DMSendDecktoptoGrave(player,count,reason)
	--player: the player whose cards to send to the graveyard
	--count: the number of cards to send to the graveyard
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.DMSendtoGrave(g,reason)
end
--send a card from the top of a player's deck to the shield zone
function Duel.SendDecktoptoSZone(player,count)
	--player: the player whose cards to send to the shield zone
	--count: the number of cards to send to the shield zone
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.SendtoSZone(g)
end
--send up to a number of cards from the top of a player's deck to the mana zone
--reserved
--[[
function Duel.SendDecktoptoMZoneUpTo(player,count,pos,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanSendDecktoptoMZone(player,1) and Duel.SelectYesNo(player,YESNOMSG_TOMZONE) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCETOMZONE)
		local an=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.SendDecktoptoMZone(player,an,pos,reason)
	end
	return 0
end
]]
--send up to a number of cards from the top of a player's deck to the shield zone
function Duel.SendDecktoptoSZoneUpTo(player,count)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count==0 or not Duel.IsPlayerCanSendDecktoptoSZone(player,1)
		or not Duel.SelectYesNo(player,YESNOMSG_TOSZONE) then return 0 end
	if deck_count>count then deck_count=count end
	local t={}
	for i=1,deck_count do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCETOSZONE)
	local an=Duel.AnnounceNumber(player,table.unpack(t))
	return Duel.SendDecktoptoSZone(player,an)
end
--workaround to prevent the game from removing evolution source
function Duel.KeepEvolutionSource(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local c=e:GetHandler()
			local g=c:GetEvolutionSourceGroup()
			if g:GetCount()==0 then return end
			local tc=g:Filter(aux.FilterEqualFunction(Card.GetSequence,1),nil):GetFirst() or g:GetFirst()
			local zone=bit.lshift(0x1,c:GetPreviousSequence())
			Duel.MoveToField(tc,tp,c:GetPreviousControler(),LOCATION_BZONE,c:GetPreviousPosition(),true,zone)
			g:RemoveCard(tc)
			Duel.Overlay(tc,g)
			e:Reset()
		end)
		tc:RegisterEffect(e1)
	end
end
--send the top card of an evolution creature to the mana zone
function Duel.SendTopCardtoMZone(targets,pos,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		--workaround to prevent the game from removing evolution source
		Duel.KeepEvolutionSource(tc)
		res=res+Duel.SendtoMZone(tc,pos,reason,true)
	end
	return res
end
--send the top card of an evolution creature to the graveyard
function Duel.DMSendTopCardtoGrave(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		--workaround to prevent the game from removing evolution source
		Duel.KeepEvolutionSource(tc)
		res=res+Duel.DMSendtoGrave(tc,reason,true)
	end
	return res
end
--check if a player can send a card from the top of their deck to the graveyard
--reserved
--[[
function Duel.DMIsPlayerCanSendDecktoptoGrave(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.DMIsAbleToGrave,nil)>0
end
]]
--check if a player can send a card from the top of their deck to the shield zone
function Duel.IsPlayerCanSendDecktoptoSZone(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.IsAbleToSZone,nil)>0
end
--put a card on top of another card
function Duel.PutOnTop(c,targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	c:SetMaterial(targets)
	for tc in aux.Next(targets) do
		--retain underlying cards
		local g=tc:GetUnderlyingGroup()
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
		Duel.Overlay(c,tc)
	end
end
--draw up to a number of cards
function Duel.DrawUpTo(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanDraw(player,1) and Duel.SelectYesNo(player,YESNOMSG_DRAW) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCEDRAW)
		local draw_count=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.Draw(player,draw_count,reason)
	end
	return 0
end
--discard a card at random
function Duel.RandomDiscardHand(player,count,reason,ex)
	reason=reason or REASON_EFFECT
	local g=Duel.GetFieldGroup(player,LOCATION_HAND,0)
	if type(ex)=="Card" then g:RemoveCard(ex)
	elseif type(ex)=="Group" then g:Sub(ex) end
	if g:GetCount()==0 then return 0 end
	local sg=g:RandomSelect(player,count)
	return Duel.Remove(sg,POS_FACEUP,reason+REASON_DISCARD)
end
--check if a player can untap the cards in their mana zone at the start of each of their turns
function Duel.IsPlayerCanUntapStartStep(player)
	return not Duel.IsPlayerAffectedByEffect(player,EFFECT_PLAYER_CANNOT_UNTAP_START)
end
--get the creature that is blocking
function Duel.GetBlocker()
	local f=function(c)
		return c:GetFlagEffect(EFFECT_BLOCKER)>0
	end
	return Duel.GetFirstMatchingCard(f,0,LOCATION_BZONE,LOCATION_BZONE,nil)
end
--get the number of shields a player has
function Duel.GetShieldCount(player)
	return Duel.GetMatchingGroupCount(aux.ShieldZoneFilter(),player,LOCATION_SZONE,0,nil)
end
--get the number of shields a player's cards broke this turn
function Duel.GetBrokenShieldCount(player)
	return Duel.GetFlagEffect(player,EFFECT_BREAK_SHIELD)
end
--get the number of cards a player has in their mana zone
function Duel.GetManaCount(player)
	return Duel.GetMatchingGroupCount(aux.ManaZoneFilter(),player,LOCATION_MZONE,0,nil)
end
--choose a race
function Duel.DMAnnounceRace(player)
	local opt=Duel.SelectOption(player,table.unpack(aux.race_desc_list))+1
	return aux.race_value_list[opt]
end
--Note: Update these lists if a new non-group race is introduced
aux.race_desc_list={
	OPTION_ANGEL_COMMAND,
	OPTION_ARMORED_DRAGON,
	OPTION_ARMORED_WYVERN,
	OPTION_ARMORLOID,
	OPTION_BALLOON_MUSHROOM,
	OPTION_BEAST_FOLK,
	OPTION_BERSERKER,
	OPTION_BRAIN_JACKER,
	OPTION_CHIMERA,
	OPTION_COLONY_BEETLE,
	OPTION_CYBER_CLUSTER,
	OPTION_CYBER_LORD,
	OPTION_CYBER_MOON,
	OPTION_CYBER_VIRUS,
	OPTION_DARK_LORD,
	OPTION_DEATH_PUPPET,
	OPTION_DEMON_COMMAND,
	OPTION_DEVIL_MASK,
	OPTION_DRAGO_NOID,
	OPTION_DUNE_GECKO,
	OPTION_EARTH_DRAGON,
	OPTION_EARTH_EATER,
	OPTION_FIRE_BIRD,
	OPTION_FISH,
	OPTION_GEL_FISH,
	OPTION_GHOST,
	OPTION_GIANT,
	OPTION_GIANT_INSECT,
	OPTION_GLADIATOR,
	OPTION_GUARDIAN,
	OPTION_HEDRIAN,
	OPTION_HORNED_BEAST,
	OPTION_HUMAN,
	OPTION_INITIATE,
	OPTION_LEVIATHAN,
	OPTION_LIGHT_BRINGER,
	OPTION_LIQUID_PEOPLE,
	OPTION_LIVING_DEAD,
	OPTION_MACHINE_EATER,
	OPTION_MECHA_DEL_SOL,
	OPTION_MECHA_THUNDER,
	OPTION_MELT_WARRIOR,
	OPTION_MERFOLK,
	OPTION_MYSTERY_TOTEM,
	OPTION_NAGA,
	OPTION_PANDORAS_BOX,
	OPTION_PARASITE_WORM,
	OPTION_PEGASUS,
	OPTION_PHOENIX,
	OPTION_RAINBOW_PHANTOM,
	OPTION_ROCK_BEAST,
	OPTION_SEA_HACKER,
	OPTION_SNOW_FAERIE,
	OPTION_SOLTROOPER,
	OPTION_SPIRIT_QUARTZ,
	OPTION_STARLIGHT_TREE,
	OPTION_STARNOID,
	OPTION_SURVIVOR,
	OPTION_TREE_FOLK,
	OPTION_VOLCANO_DRAGON,
	OPTION_WILD_VEGGIES,
	OPTION_XENOPARTS,
	OPTION_ZOMBIE_DRAGON,
}
aux.race_value_list={
	RACE_ANGEL_COMMAND,
	RACE_ARMORED_DRAGON,
	RACE_ARMORED_WYVERN,
	RACE_ARMORLOID,
	RACE_BALLOON_MUSHROOM,
	RACE_BEAST_FOLK,
	RACE_BERSERKER,
	RACE_BRAIN_JACKER,
	RACE_CHIMERA,
	RACE_COLONY_BEETLE,
	RACE_CYBER_CLUSTER,
	RACE_CYBER_LORD,
	RACE_CYBER_MOON,
	RACE_CYBER_VIRUS,
	RACE_DARK_LORD,
	RACE_DEATH_PUPPET,
	RACE_DEMON_COMMAND,
	RACE_DEVIL_MASK,
	RACE_DRAGO_NOID,
	RACE_DUNE_GECKO,
	RACE_EARTH_DRAGON,
	RACE_EARTH_EATER,
	RACE_FIRE_BIRD,
	RACE_FISH,
	RACE_GEL_FISH,
	RACE_GHOST,
	RACE_GIANT,
	RACE_GIANT_INSECT,
	RACE_GLADIATOR,
	RACE_GUARDIAN,
	RACE_HEDRIAN,
	RACE_HORNED_BEAST,
	RACE_HUMAN,
	RACE_INITIATE,
	RACE_LEVIATHAN,
	RACE_LIGHT_BRINGER,
	RACE_LIQUID_PEOPLE,
	RACE_LIVING_DEAD,
	RACE_MACHINE_EATER,
	RACE_MECHA_DEL_SOL,
	RACE_MECHA_THUNDER,
	RACE_MELT_WARRIOR,
	RACE_MERFOLK,
	RACE_MYSTERY_TOTEM,
	RACE_NAGA,
	RACE_PANDORAS_BOX,
	RACE_PARASITE_WORM,
	RACE_PEGASUS,
	RACE_PHOENIX,
	RACE_RAINBOW_PHANTOM,
	RACE_ROCK_BEAST,
	RACE_SEA_HACKER,
	RACE_SNOW_FAERIE,
	RACE_SOLTROOPER,
	RACE_SPIRIT_QUARTZ,
	RACE_STARLIGHT_TREE,
	RACE_STARNOID,
	RACE_SURVIVOR,
	RACE_TREE_FOLK,
	RACE_VOLCANO_DRAGON,
	RACE_WILD_VEGGIES,
	RACE_XENOPARTS,
	RACE_ZOMBIE_DRAGON,
}
--choose a mana cost
function Duel.AnnounceCost(player)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCECOST)
	return Duel.AnnounceNumber(tp,table.unpack(aux.mana_cost_list))
end
--Note: Update this list if a new mana cost is introduced
aux.mana_cost_list={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,24,25,30,39,40,50,71,99,999,MAX_MANA_COST}
--cast a spell immediately for no cost
function Duel.CastFree(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		Duel.DisableShuffleCheck(true)
		Duel.SendtoHand(tc,PLAYER_OWNER,reason)
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_CAST_FREE,tc:GetReasonEffect(),0,0,0,0)
		Duel.DisableShuffleCheck(false)
		res=res+1
	end
	return res
end
--Renamed Duel functions
--let 2 creatures do battle with each other
Duel.DoBattle=Duel.CalculateDamage
--choose a civilization
Duel.AnnounceCivilization=Duel.AnnounceAttribute
--check if a player can send a card from the top of their deck to the mana zone
Duel.IsPlayerCanSendDecktoptoMZone=Duel.IsPlayerCanDiscardDeck
