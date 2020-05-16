--Temporary Card functions
--check if a card's mana cost is equal to a given value
local card_is_level=Card.IsLevel
function Card.IsLevel(c,lv)
	if card_is_level then
		return card_is_level(c,lv)
	else
		return c:GetLevel()==lv
	end
end
--check if a card's power is equal to a given value
local card_is_attack=Card.IsAttack
function Card.IsAttack(c,atk)
	if card_is_attack then
		return card_is_attack(c,atk)
	else
		return c:GetAttack()==atk
	end
end
--check if a card has a particular race or name category
local card_is_set_card=Card.IsSetCard
function Card.IsSetCard(c,...)
	local setname_list={...}
	for _,setname in ipairs(setname_list) do
		if card_is_set_card(c,setname,...) then return true end
	end
	return false
end
--Overwritten Card functions
--check if a card can be sent to the battle zone
local card_is_can_be_special_summoned=Card.IsCanBeSpecialSummoned
function Card.IsCanBeSpecialSummoned(c,...)
	--workaround to allow face-down banished monsters to special summon
	if c:IsLocation(LOCATION_MZONETAP) and c:IsFacedown() then return true end
	return card_is_can_be_special_summoned(c,...)
end
Card.IsAbleToBZone=Card.IsCanBeSpecialSummoned
--check if a card can attack
local card_is_attackable=Card.IsAttackable
function Card.IsAttackable(c)
	if c:IsHasEffect(EFFECT_IGNORE_CANNOT_ATTACK) then return true end
	return card_is_attackable(c)
end
Card.IsCanAttack=Card.IsAttackable
--New Card functions
--check if a card is a creature
function Card.IsCreature(c)
	return c:IsType(TYPE_CREATURE)
end
--check if a card is an evolution creature
function Card.IsEvolution(c)
	return c:IsType(TYPE_EVOLUTION)
end
--check if a card is a spell
function Card.IsSpell(c)
	return c:IsType(TYPE_SPELL)
end
--check if a card has 2 or more civilizations
function Card.IsMulticolored(c)
	return c:IsType(TYPE_MULTICOLORED)
end
--check if a card is a shield
function Card.IsShield(c)
	return c:IsLocation(LOCATION_SZONE) and c:GetSequence()<5
end
--check if a card is a broken shield
function Card.IsBrokenShield(c)
	return c:GetFlagEffect(EFFECT_BROKEN_SHIELD)>0
end
--check if a card is untapped
function Card.IsUntapped(c)
	if c:IsLocation(LOCATION_MZONEUNT) then
		return c:IsFaceup()
	elseif c:IsLocation(LOCATION_BZONE) then
		return c:IsAttackPos()
	end
	return false
end
--check if a card is tapped
function Card.IsTapped(c)
	if c:IsLocation(LOCATION_MZONETAP) then
		return c:IsFacedown()
	elseif c:IsLocation(LOCATION_BZONE) then
		return c:IsDefensePos()
	end
	return false
end
--check if a card can be untapped
function Card.IsAbleToUntap(c)
	if c:IsLocation(LOCATION_MZONETAP) then
		return c:IsAbleToGrave()
	elseif c:IsLocation(LOCATION_BZONE) then
		return c:IsDefensePos()
	end
	return false
end
--check if a card can be untapped at the start of the turn
function Card.IsAbleToUntapStartStep(c)
	return c:IsTapped() and not c:IsHasEffect(EFFECT_DONOT_UNTAP_START_STEP)
end
--check if a card can be tapped
--Note: Remove EFFECT_IGNORE_TAP check if YGOPro allows a creature to tap itself for EFFECT_ATTACK_COST
function Card.IsAbleToTap(c)
	if c:GetFlagEffect(EFFECT_IGNORE_TAP)>0 then return false end
	if c:IsLocation(LOCATION_MZONEUNT) then
		return c:IsAbleToRemove()
	elseif c:IsLocation(LOCATION_BZONE) then
		return c:IsAttackPos()
	end
	return false
end
--check if a card is in the mana zone
function Card.IsMana(c)
	return (c:IsUntapped() or c:IsTapped()) and c:IsLocation(LOCATION_MZONE)
end
--check if a card is in the graveyard
function Card.IsGrave(c)
	return c:IsFaceup() and c:IsLocation(LOCATION_GRAVE)
end
--check if a card can be sent to the shield zone
function Card.IsAbleToSZone(c)
	--reserved
	return true--not c:IsHasEffect(EFFECT_CANNOT_TO_SZONE)
end
--check if a card can be sent to the mana zone
function Card.IsAbleToMZone(c)
	--reserved
	--if c:IsHasEffect(EFFECT_CANNOT_TO_MZONE) then return false end
	return c:IsAbleToGrave()
end
--check if a card can be sent to the graveyard
function Card.DMIsAbleToGrave(c)
	--reserved
	--if c:IsHasEffect(EFFECT_CANNOT_TO_GRAVE) then return false end
	return c:IsAbleToRemove()
end
--check if a spell can be cast for no cost
function Card.IsCanCastFree(c)
	return c:GetPlayCost()<=0
end
--check if a card has become blocked
function Card.IsBlocked(c)
	return c:GetFlagEffect(EFFECT_BLOCKED)>0
end
--check if a card can attack a player
function Card.IsCanAttackPlayer(c)
	if c:IsHasEffect(EFFECT_IGNORE_CANNOT_ATTACK_PLAYER) then return true end
	return not c:IsHasEffect(EFFECT_CANNOT_ATTACK_PLAYER)
end
--check if a card can attack a creature
function Card.IsCanAttackCreature(c)
	return not c:IsHasEffect(EFFECT_CANNOT_ATTACK_CREATURE)
end
--check if a card can attack during the same turn it is sent to the battle zone
function Card.IsCanAttackTurn(c)
	return c:IsEvolution() or c:IsHasEffect(EFFECT_SPEED_ATTACKER) or c:IsHasEffect(EFFECT_IGNORE_SUMMONING_SICKNESS)
end
--check if a card can be attacked while untapped
function Card.IsCanBeUntappedAttacked(c)
	return c:IsHasEffect(EFFECT_UNTAPPED_BE_ATTACKED)
end
--check if a card can attack an untapped creature
function Card.IsCanAttackUntapped(c)
	return c:IsHasEffect(EFFECT_ATTACK_UNTAPPED)
end
--check if a player can use the "blocker" ability of a card
function Card.IsCanBlock(c,player)
	--reserved
	--if player and Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_BLOCK) then return false end
	return true--not c:IsHasEffect(EFFECT_CANNOT_BLOCK)
end
--check if a player can use the tap ability of a card
function Card.IsCanUseTapAbility(c,player)
	if player and Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_USE_TAP_ABILITY) then return false end
	return not c:IsHasEffect(EFFECT_CANNOT_USE_TAP_ABILITY)
end
--check if a card can break a shield
function Card.IsCanBreakShield(c)
	--reserved
	return true--not c:IsHasEffect(EFFECT_CANNOT_BREAK_SHIELD)
end
--get the number of shields a card broke this turn
function Card.GetBrokenShieldCount(c)
	return c:GetFlagEffect(EFFECT_BREAK_SHIELD)
end
--check if a player can summon a card
function Card.DMIsSummonable(c,player)
	--if player and Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_SUMMON_CREATURE) then return false end --reserved
	return not c:IsHasEffect(EFFECT_CANNOT_SUMMON_CREATURE)
end
--check if a card has a particular race to put the appropriate evolution creature on it
function Card.IsEvolutionRace(c,...)
	local race_list={...}
	for _,racename in ipairs(race_list) do
		if c:DMIsRace(racename) or c:IsHasEffect(EFFECT_EVOLUTION_ANY_RACE) then return true end
	end
	return false
end
--check if a card has a particular name in its race to put the appropriate evolution creature on it
function Card.IsEvolutionRaceCategory(c,...)
	local cat_list={...}
	for _,racecat in ipairs(cat_list) do
		if c:IsRaceCategory(racecat) or c:IsHasEffect(EFFECT_EVOLUTION_ANY_RACE) then return true end
	end
	return false
end
--get a card's evolution source
function Card.GetEvolutionSourceGroup(c)
	return c:GetOverlayGroup()
end
--get the amount of evolution source a card has
function Card.GetEvolutionSourceCount(c)
	return c:GetOverlayCount(c)
end
--check if a card has evolution source
function Card.IsHasEvolutionSource(c)
	return c:GetEvolutionSourceCount()>0
end
--check if an evolution source can leave the battle zone
function Card.IsCanEvolutionSourceLeave(c)
	return not c:IsHasEffect(EFFECT_EVOLUTION_SOURCE_REMAIN)
end
--check if there is a card under a card
function Card.IsHasUnderlyingCard(c)
	return c:GetOverlayCount()>0
end
--get the amount of civilizations a card has
function Card.GetCivilizationCount(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATION_LIGHT or civ==CIVILIZATION_WATER or civ==CIVILIZATION_DARKNESS
		or civ==CIVILIZATION_FIRE or civ==CIVILIZATION_NATURE then
		return 1
	elseif civ==CIVILIZATIONS_LW or civ==CIVILIZATIONS_LD or civ==CIVILIZATIONS_WD
		or civ==CIVILIZATIONS_LF or civ==CIVILIZATIONS_WF or civ==CIVILIZATIONS_DF
		or civ==CIVILIZATIONS_LN or civ==CIVILIZATIONS_WN or civ==CIVILIZATIONS_DN
		or civ==CIVILIZATIONS_FN then
		return 2
	elseif civ==CIVILIZATIONS_DFN or civ==CIVILIZATIONS_LFN or civ==CIVILIZATIONS_LWD
		or civ==CIVILIZATIONS_LWN or civ==CIVILIZATIONS_WDF or civ==CIVILIZATIONS_LDF
		or civ==CIVILIZATIONS_LDN or civ==CIVILIZATIONS_LWF or civ==CIVILIZATIONS_WDN
		or civ==CIVILIZATIONS_WFN then
		return 3
	elseif civ==CIVILIZATIONS_LWDF then
		return 4
	elseif civ==CIVILIZATIONS_LWDFN then
		return 5
	else return 0 end
end
--get the first or only civilization a card has
function Card.GetFirstCivilization(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATION_LIGHT or civ==CIVILIZATIONS_LW or civ==CIVILIZATIONS_LD
		or civ==CIVILIZATIONS_LF or civ==CIVILIZATIONS_LN or civ==CIVILIZATIONS_LFN
		or civ==CIVILIZATIONS_LWD or civ==CIVILIZATIONS_LWN or civ==CIVILIZATIONS_LDF
		or civ==CIVILIZATIONS_LDN or civ==CIVILIZATIONS_LWF or civ==CIVILIZATIONS_LWDF
		or civ==CIVILIZATIONS_LWDFN then
		return CIVILIZATION_LIGHT
	elseif civ==CIVILIZATION_WATER or civ==CIVILIZATIONS_WD or civ==CIVILIZATIONS_WF
		or civ==CIVILIZATIONS_WN or civ==CIVILIZATIONS_WDF or civ==CIVILIZATIONS_WDN
		or civ==CIVILIZATIONS_WFN then
		return CIVILIZATION_WATER
	elseif civ==CIVILIZATION_DARKNESS or civ==CIVILIZATIONS_DF or civ==CIVILIZATIONS_DN
		or civ==CIVILIZATIONS_DFN then
		return CIVILIZATION_DARKNESS
	elseif civ==CIVILIZATION_FIRE or civ==CIVILIZATIONS_FN then
		return CIVILIZATION_FIRE
	elseif civ==CIVILIZATION_NATURE then
		return CIVILIZATION_NATURE
	else return CIVILIZATION_NONE end
end
--get the second civilization a multicolored card has
function Card.GetSecondCivilization(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATIONS_LW or civ==CIVILIZATIONS_LWD or civ==CIVILIZATIONS_LWN
		or civ==CIVILIZATIONS_LWF or civ==CIVILIZATIONS_LWDF or civ==CIVILIZATIONS_LWDFN then
		return CIVILIZATION_WATER
	elseif civ==CIVILIZATIONS_LD or civ==CIVILIZATIONS_WD or civ==CIVILIZATIONS_WDF
		or civ==CIVILIZATIONS_LDF or civ==CIVILIZATIONS_LDN or civ==CIVILIZATIONS_WDN then
		return CIVILIZATION_DARKNESS
	elseif civ==CIVILIZATIONS_LF or civ==CIVILIZATIONS_WF or civ==CIVILIZATIONS_DF
		or civ==CIVILIZATIONS_DFN or civ==CIVILIZATIONS_LFN or civ==CIVILIZATIONS_WFN then
		return CIVILIZATION_FIRE
	elseif civ==CIVILIZATIONS_LN or civ==CIVILIZATIONS_WN or civ==CIVILIZATIONS_DN
		or civ==CIVILIZATIONS_FN then
		return CIVILIZATION_NATURE
	else return CIVILIZATION_NONE end
end
--get the third civilization a multicolored card has
function Card.GetThirdCivilization(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATIONS_LWD or civ==CIVILIZATIONS_LWDF or civ==CIVILIZATIONS_LWDFN then
		return CIVILIZATION_DARKNESS
	elseif civ==CIVILIZATIONS_WDF or civ==CIVILIZATIONS_LDF or civ==CIVILIZATIONS_LWF then
		return CIVILIZATION_FIRE
	elseif civ==CIVILIZATIONS_DFN or civ==CIVILIZATIONS_LFN or civ==CIVILIZATIONS_LWN
		or civ==CIVILIZATIONS_LDN or civ==CIVILIZATIONS_WDN or civ==CIVILIZATIONS_WFN then
		return CIVILIZATION_NATURE
	else return CIVILIZATION_NONE end
end
--get the fourth civilization a multicolored card has
function Card.GetFourthCivilization(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATIONS_LWDF or civ==CIVILIZATIONS_LWDFN then
		return CIVILIZATION_FIRE
	else return CIVILIZATION_NONE end
end
--get the fifth civilization a multicolored card has
function Card.GetFifthCivilization(c)
	local civ=c:GetCivilization()
	if civ==CIVILIZATIONS_LWDFN then
		return CIVILIZATION_NATURE
	else return CIVILIZATION_NONE end
end
--check if a card's mana cost is equal to a given value
function Card.IsManaCost(c,cost)
	return c:GetManaCost()==cost
end
--check if a card's mana cost is less than or equal to a given value
function Card.IsManaCostBelow(c,cost)
	return c:GetManaCost()<=cost
end
--check if a card's mana cost is greater than or equal to a given value
function Card.IsManaCostAbove(c,cost)
	return c:GetManaCost()>=cost
end
--check if a card has a particular race
function Card.DMIsRace(c,...)
	local setname_list={...}
	if not RaceList then RaceList={} end
	for _,setname in ipairs(setname_list) do
		if c:IsSetCard(setname,...) then
			for _,racename in ipairs(RaceList) do
				if setname==racename then return true end
			end
		end
	end
	return false
end
--get all races a card has
function Card.DMGetRace(c)
	local race=0
	local ct=1
	while ct<=4095 and race==0 do
		if c:DMIsRace(ct) then
			race=race+ct
		end
		ct=ct+1
	end
	return race
end
--check if a card has a race
function Card.IsHasRace(c)
	local race=false
	local ct=1
	while ct<=4095 and race==false do
		if c:DMIsRace(ct) then
			race=true
		end
		ct=ct+1
	end
	return race
end
--check if a card has a particular name included in its race
function Card.IsRaceCategory(c,...)
	local setname_list={...}
	if not RaceCatList then RaceCatList={} end
	for _,setname in ipairs(setname_list) do
		if c:IsSetCard(setname,...) then
			for _,racecat in ipairs(RaceCatList) do
				if setname==racecat then return true end
			end
		end
	end
	return false
end
--Renamed Card functions
--check if a card had a particular race before it left the battle zone
Card.DMIsPreviousRace=Card.IsPreviousSetCard
--check if a card has a particular name in its card name
--Card.IsNameCategory=Card.IsSetCard --reserved
--get the cost required for playing a card
Card.GetPlayCost=Card.GetLevel
--get a card's mana cost
Card.GetManaCost=Card.GetOriginalLevel
--get all civilizations a card has
Card.GetCivilization=Card.GetAttribute
--check if a card has a particular civilization
Card.IsCivilization=Card.IsAttribute
--get a card's current power
Card.GetPower=Card.GetAttack
--check if a card's power is equal to a given value
Card.IsPower=Card.IsAttack
--check if a card's power is less than or equal to a given value
Card.IsPowerBelow=Card.IsAttackBelow
--check if a card's power is greater than or equal to a given value
Card.IsPowerAbove=Card.IsAttackAbove
--get the cards under a card
Card.GetUnderlyingGroup=Card.GetOverlayGroup
--get the number of cards under a card
Card.GetUnderlyingCount=Card.GetOverlayCount
