Auxiliary={}
aux=Auxiliary

--
function Auxiliary.Stringid(code,id)
	return code*16+id
end
--
function Auxiliary.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
--
function Auxiliary.NULL()
end
--
function Auxiliary.TRUE()
	return true
end
--
function Auxiliary.FALSE()
	return false
end
--
function Auxiliary.AND(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if not res then return res end
				end
				return res
			end
end
--
function Auxiliary.OR(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if res then return res end
				end
				return res
			end
end
--
function Auxiliary.NOT(f)
	return	function(...)
				return not f(...)
			end
end
--
function Auxiliary.BeginPuzzle(effect)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.PuzzleOp)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_SKIP_SP)
	e3:SetTargetRange(1,0)
	Duel.RegisterEffect(e3,0)
end
function Auxiliary.PuzzleOp(e,tp)
	Duel.SetLP(0,0)
end
--
function Auxiliary.TargetEqualFunction(f,value,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.TargetBoolFunction(f,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))
			end
end
--
function Auxiliary.FilterEqualFunction(f,value,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.FilterBoolFunction(f,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))
			end
end
--get a card script's name and id
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end
--add a setcode to a card
--required to register a card's race and name category
function Auxiliary.AddSetcode(c,setname)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetValue(setname)
	c:RegisterEffect(e1)
	local m=_G["c"..c:GetOriginalCode()]
	if not m.overlay_setcode_check then
		m.overlay_setcode_check=true
		--fix for evolution source not getting a setcode
		local e2=Effect.GlobalEffect()
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetTargetRange(LOCATION_ESOURCE,LOCATION_ESOURCE)
		e2:SetLabel(c:GetCode())
		e2:SetTarget(function(e,c)
			return c:GetCode()==e:GetLabel()
		end)
		e2:SetValue(setname)
		Duel.RegisterEffect(e2,0)
	end
end
--register a card's race(s)
--required for Card.DMIsRace, Card.DMGetRace, Card.IsHasRace
function Auxiliary.AddRace(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.race==nil then
		local mt=getmetatable(c)
		mt.race={}
		for _,racename in ipairs{...} do
			table.insert(mt.race,racename)
		end
	else
		for _,racename in ipairs{...} do
			table.insert(c.race,racename)
		end
	end
end
--register a card's race category(s)
--required for Card.IsRaceCategory
function Auxiliary.AddRaceCategory(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.race_category==nil then
		local mt=getmetatable(c)
		mt.race_category={}
		for _,racecat in ipairs{...} do
			table.insert(mt.race_category,racecat)
		end
	else
		for _,racecat in ipairs{...} do
			table.insert(c.race_category,racecat)
		end
	end
end
--register a card's name category(s)
--required for Card.IsNameCategory
function Auxiliary.AddNameCategory(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.name_category==nil then
		local mt=getmetatable(c)
		mt.name_category={}
		for _,namecat in ipairs{...} do
			table.insert(mt.name_category,namecat)
		end
	else
		for _,namecat in ipairs{...} do
			table.insert(c.name_category,namecat)
		end
	end
end
--add a description to a card that lists the effects it gained
--Note: The description is removed if con_func returns false
function Auxiliary.AddEffectDescription(c,desc_id,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetOperation(Auxiliary.AddEffectDescOperation(desc_id))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	if con_func then e2:SetCondition(aux.NOT(con_func)) end
	e2:SetOperation(Auxiliary.RemoveEffectDescOperation(desc_id))
	c:RegisterEffect(e2)
end
function Auxiliary.AddEffectDescOperation(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local desc=aux.Stringid(c:GetOriginalCode(),desc_id)
				local code=desc_id+300 --300 > the number of cards that exists in a card's set
				if c:GetFlagEffect(code)==0 then
					c:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,EFFECT_FLAG_CLIENT_HINT,1,0,desc)
				end
			end
end
function Auxiliary.RemoveEffectDescOperation(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local code=desc_id+300
				if c:GetFlagEffect(code)>0 then
					c:ResetFlagEffect(code)
				end
			end
end
--sort cards on the top or bottom of a player's deck
function Auxiliary.SortDeck(sort_player,target_player,count,seq)
	--sort_player: the player who sorts the cards
	--target_player: the player whose cards to sort
	--count: the number of cards to sort
	--seq: SEQ_DECK_TOP to sort the top cards or SEQ_DECK_BOTTOM to sort the bottom cards
	local deck_count=Duel.GetFieldGroupCount(target_player,LOCATION_DECK,0)
	if deck_count<count then count=deck_count end
	if count>1 then Duel.SortDecktop(sort_player,target_player,count) end
	if seq~=SEQ_DECK_BOTTOM or count<=0 then return end
	local g=Duel.GetDecktopGroup(target_player,1)
	if count>1 then
		for i=1,count do
			Duel.MoveSequence(g:GetFirst(),seq)
		end
	else Duel.MoveSequence(g:GetFirst(),seq) end
end
--check if an evolution creature evolves from a specified race category
--required for "Spiritual Star Dragon" (DM-13 12/55)
function Auxiliary.IsEvolutionListRaceCategory(c,...)
	if not c.evolution_race_cat_list then return false end
	local cat_list={...}
	for _,racecat in ipairs(cat_list) do
		for _,evoname in ipairs(c.evolution_race_cat_list) do
			if evoname==racecat then return true end
		end
	end
	return false
end

--creature card
function Auxiliary.EnableCreatureAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
	--summon procedure
	Auxiliary.AddSummonProcedure(c)
	--summon for no cost using "shield trigger"
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SHIELD_TRIGGER_C)
	e1:SetCategory(CATEGORY_SHIELD_TRIGGER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_TRIGGER)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.ShieldTriggerCondition1)
	e1:SetTarget(Auxiliary.ShieldTriggerSummonTarget)
	e1:SetOperation(Auxiliary.ShieldTriggerSummonOperation)
	c:RegisterEffect(e1)
	--prevent multiple "shield trigger" abilities from chaining
	Auxiliary.AddShieldTriggerChainLimit(c,e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetCondition(Auxiliary.CannotBeBattleTargetCondition)
	e2:SetValue(Auxiliary.CannotBeBattleTargetValue)
	c:RegisterEffect(e2)
	--attack shield
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_SHIELD)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(Auxiliary.AttackShieldCondition)
	e3:SetOperation(Auxiliary.AttackShieldOperation)
	c:RegisterEffect(e3)
end
--register card info
function Auxiliary.RegisterCardInfo(c)
	if not RaceList then RaceList={} end
	if not RaceCatList then RaceCatList={} end
	local m=_G["c"..c:GetCode()]
	--register race
	if m and m.race then
		for _,racename in ipairs(m.race) do
			Auxiliary.AddSetcode(c,racename)
			table.insert(RaceList,racename)
		end
	end
	--register race category
	if m and m.race_category then
		for _,racecat in ipairs(m.race_category) do
			Auxiliary.AddSetcode(c,racecat)
			table.insert(RaceCatList,racecat)
		end
	end
	--register name category
	if m and m.name_category then
		for _,namecat in ipairs(m.name_category) do
			Auxiliary.AddSetcode(c,namecat)
		end
	end
end
--summon procedure
function Auxiliary.AddSummonProcedure(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_CREATURE_PROC)
	e1:SetProperty(EFFECT_FLAG_SUMMON_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_UNTAPPED,0)
	e1:SetCondition(Auxiliary.NonEvolutionSummonCondition)
	e1:SetOperation(Auxiliary.NonEvolutionSummonOperation)
	e1:SetValue(SUMMON_TYPE_NONEVOLVE)
	c:RegisterEffect(e1)
end
function Auxiliary.PayManaFilter(c)
	return c:IsAbleToTap()
end
function Auxiliary.NonEvolutionSummonCondition(e,c)
	if c==nil then return true end
	if c:IsEvolution() or not c:DMIsSummonable() then return false end
	local tp=c:GetControler()
	local cost=c:GetPlayCost()
	local civ_count=c:GetCivilizationCount()
	local g=Duel.GetMatchingGroup(Auxiliary.PayManaFilter,tp,LOCATION_MZONE,0,nil)
	if Duel.GetLocationCount(tp,LOCATION_BZONE)<=0 or g:GetCount()<cost or civ_count>cost then return false end
	return Auxiliary.PayManaCondition(g,c,civ_count)
end
function Auxiliary.PayManaCondition(g,c,civ_count)
	local b1=g:IsExists(Card.IsCivilization,1,nil,c:GetFirstCivilization())
	local b2=g:IsExists(Card.IsCivilization,1,nil,c:GetSecondCivilization())
	local b3=g:IsExists(Card.IsCivilization,1,nil,c:GetThirdCivilization())
	local b4=g:IsExists(Card.IsCivilization,1,nil,c:GetFourthCivilization())
	local b5=g:IsExists(Card.IsCivilization,1,nil,c:GetFifthCivilization())
	if civ_count==1 then
		return b1
	elseif civ_count==2 then
		return b1 and b2
	elseif civ_count==3 then
		return b1 and b2 and b3
	elseif civ_count==4 then
		return b1 and b2 and b3 and b4
	elseif civ_count==5 then
		return b1 and b2 and b3 and b4 and b5
	end
end
function Auxiliary.PayManaSelect(g,sel_player,c,mana_cost,civ_count)
	local sg=Group.CreateGroup()
	if civ_count>=1 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg1=g:FilterSelect(sel_player,Card.IsCivilization,1,1,nil,c:GetFirstCivilization())
		g:Sub(sg1)
		sg:Merge(sg1)
	end
	if civ_count>=2 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg2=g:FilterSelect(sel_player,Card.IsCivilization,1,1,nil,c:GetSecondCivilization())
		g:Sub(sg2)
		sg:Merge(sg2)
	end
	if civ_count>=3 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg3=g:FilterSelect(sel_player,Card.IsCivilization,1,1,nil,c:GetThirdCivilization())
		g:Sub(sg3)
		sg:Merge(sg3)
	end
	if civ_count>=4 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg4=g:FilterSelect(sel_player,Card.IsCivilization,1,1,nil,c:GetFourthCivilization())
		g:Sub(sg4)
		sg:Merge(sg4)
	end
	if civ_count>=5 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg5=g:FilterSelect(sel_player,Card.IsCivilization,1,1,nil,c:GetFifthCivilization())
		g:Sub(sg5)
		sg:Merge(sg5)
	end
	local ct=mana_cost-civ_count
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,sel_player,HINTMSG_TAP)
		local sg6=g:Select(sel_player,ct,ct,nil)
		g:Sub(sg6)
		sg:Merge(sg6)
	end
	Duel.PayManaCost(sg)
end
function Auxiliary.NonEvolutionSummonOperation(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Auxiliary.PayManaFilter,tp,LOCATION_MZONE,0,nil)
	Auxiliary.PayManaSelect(g,tp,c,c:GetPlayCost(),c:GetCivilizationCount())
end
--prevent multiple "shield trigger" abilities from chaining
function Auxiliary.AddShieldTriggerChainLimit(c,effect,prop,con_func)
	prop=prop or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetLabelObject():SetLabel(0)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if rp==1-tp or not re:IsHasCategory(CATEGORY_SHIELD_TRIGGER) then return end
		e:GetLabelObject():SetLabel(1)
	end)
	c:RegisterEffect(e2)
	local e3=effect:Clone()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e3:SetCondition(aux.AND(Auxiliary.ShieldTriggerCondition2,con_func))
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
--cannot be battle target
function Auxiliary.CannotBeBattleTargetCondition(e)
	local c=e:GetHandler()
	if c:IsCanBeUntappedAttacked() then return false end
	return c:IsFaceup() and c:IsUntapped()
end
function Auxiliary.CannotBeBattleTargetValue(e,c)
	--check for "This creature can attack untapped CIVILIZATION creatures."
	local t={c:IsHasEffect(EFFECT_ATTACK_UNTAPPED)}
	local civ=0
	for _,te in pairs(t) do
		civ=civ+te:GetValue()
	end
	if civ>0 then
		return not e:GetHandler():IsCivilization(civ)
	else
		return not c:IsCanAttackUntapped()
	end
end
--attack shield
function Auxiliary.AttackShieldCondition(e)
	local tp=e:GetHandlerPlayer()
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()==tp and Duel.GetShieldCount(1-tp)>0
		and Duel.GetAttacker()==c and Duel.GetAttackTarget()==nil and c:IsCanBreakShield()
end
function Auxiliary.AttackShieldOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--raise event for "Whenever this creature attacks a player"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_ATTACK_PLAYER,e,0,0,0,0)
	--(reserved) raise event for "Whenever any of your creatures attacks a player"
	--Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_ATTACK_PLAYER,e,0,0,0,0)
	Duel.BreakShield(e,tp,1-tp,1,c)
	--ignore yugioh rules
	--no battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.ChangeBattleDamage(1-tp,0)
	end)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end

--evolution procedure
function Auxiliary.AddEvolutionProcedure(c,f1,f2)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_CREATURE_PROC)
	e1:SetProperty(EFFECT_FLAG_SUMMON_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_UNTAPPED,0)
	e1:SetCondition(Auxiliary.EvolutionCondition1(f1,f2))
	e1:SetTarget(Auxiliary.EvolutionTarget(f1,f2))
	e1:SetOperation(Auxiliary.EvolutionOperation1)
	e1:SetValue(SUMMON_TYPE_EVOLVE)
	c:RegisterEffect(e1)
	--when played by effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(DESC_EVOLVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CUSTOM+EVENT_EVOLUTION_TO_BZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(Auxiliary.EvolutionCondition2(f1,f2))
	e2:SetOperation(Auxiliary.EvolutionOperation2(f1,f2))
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TO_BZONE_CONDITION)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCondition(aux.NOT(Auxiliary.EvolutionCondition2(f1,f2)))
	c:RegisterEffect(e3)
end
function Auxiliary.EvolutionFilter1(c,g,f1,f2)
	return c:IsFaceup() and (not f1 or f1(c)) and (not f2 or g:IsExists(Auxiliary.EvolutionFilter2,1,c,f2))
end
function Auxiliary.EvolutionFilter2(c,f)
	return c:IsFaceup() and (not f or f(c))
end
function Auxiliary.EvolutionCondition1(f1,f2)
	return	function(e,c)
				if c==nil then return true end
				local tp=c:GetControler()
				if not c:DMIsSummonable() then return false end
				local g1=Duel.GetMatchingGroup(Auxiliary.PayManaFilter,tp,LOCATION_MZONE,0,nil)
				local g2=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				local cost=c:GetPlayCost()
				local civ_count=c:GetCivilizationCount()
				local bzone_count=-1
				if f2 then bzone_count=-2 end
				if Duel.GetLocationCount(tp,LOCATION_BZONE)<bzone_count or g1:GetCount()<cost or civ_count>cost
					or not g2:IsExists(Auxiliary.EvolutionFilter1,1,nil,g2,f1,f2) then return false end
				return Auxiliary.PayManaCondition(g1,c,civ_count)
			end
end
function Auxiliary.EvolutionTarget(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,c)
				local g=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
				local sg1=g:FilterSelect(tp,Auxiliary.EvolutionFilter1,1,1,nil,g,f1,f2)
				Duel.HintSelection(sg1)
				local tc=sg1:GetFirst()
				local pos=tc:GetPosition()
				if f2 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
					local sg2=g:FilterSelect(tp,Auxiliary.EvolutionFilter2,1,1,tc,f2)
					Duel.HintSelection(sg2)
					sg1:Merge(sg2)
				end
				if sg1 then
					sg1:KeepAlive()
					e:SetLabelObject(sg1)
					if not f2 then e:SetTargetRange(pos,0) end
					return true
				else return false end
			end
end
function Auxiliary.EvolutionOperation1(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(Auxiliary.PayManaFilter,tp,LOCATION_MZONE,0,nil)
	Auxiliary.PayManaSelect(g1,tp,c,c:GetPlayCost(),c:GetCivilizationCount())
	local g2=e:GetLabelObject()
	Duel.PutOnTop(c,g2)
	g2:DeleteGroup()
end
function Auxiliary.EvolutionCondition2(f1,f2)
	return	function(e)
				local tp=e:GetHandler():GetControler()
				local bzone_count=-1
				if f2 then bzone_count=-2 end
				local g=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				if Duel.GetLocationCount(tp,LOCATION_BZONE)<bzone_count
					or not g:IsExists(Auxiliary.EvolutionFilter1,1,nil,g,f1,f2) then return false end
				return true
			end
end
function Auxiliary.EvolutionOperation2(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g1=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
				local sg1=g1:FilterSelect(tp,Auxiliary.EvolutionFilter1,1,1,nil,g1,f1,f2)
				Duel.HintSelection(sg1)
				local tc=sg1:GetFirst()
				local pos=tc:GetPosition()
				if f2 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
					local sg2=g1:FilterSelect(tp,Auxiliary.EvolutionFilter2,1,1,tc,f2)
					Duel.HintSelection(sg2)
					sg1:Merge(sg2)
				end
				local c=e:GetHandler()
				Duel.PutOnTop(c,sg1)
				Duel.SendtoBZone(c,0,tp,tp,true,false,pos)
			end
end

--spell card
function Auxiliary.EnableSpellAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
end

--cast spell procedure
function Auxiliary.AddSpellCastEffect(c,desc_id,targ_func,op_func,prop,con_func)
	--c: the spell card that has the ability
	--desc_id: the id of the effect's text (0-15)
	--targ_func: target function
	--op_func: operation function
	--prop: include EFFECT_FLAG_CARD_TARGET for a targeting ability
	--con_func: condition function
	prop=prop or 0
	con_func=con_func or aux.TRUE
	--cast for cost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(con_func)
	e1:SetCost(Auxiliary.CastSpellCost)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	--cast for no cost using "shield trigger"
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetCategory(CATEGORY_SHIELD_TRIGGER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(aux.AND(Auxiliary.ShieldTriggerCondition1,con_func))
	if cost_func then e2:SetCost(cost_func) end
	if targ_func then e2:SetTarget(targ_func) end
	e2:SetOperation(op_func)
	c:RegisterEffect(e2)
	--prevent multiple "shield trigger" abilities from chaining
	Auxiliary.AddShieldTriggerChainLimit(c,e2,prop,con_func)
	--cast for no cost without using "shield trigger"
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_CUSTOM+EVENT_CAST_FREE)
	e3:SetProperty(prop)
	e3:SetCondition(con_func)
	if cost_func then e3:SetCost(cost_func) end
	if targ_func then e3:SetTarget(targ_func) end
	e3:SetOperation(op_func)
	c:RegisterEffect(e3)
	--cast when getting "shield trigger"
	local e4=e3:Clone()
	e4:SetCode(EVENT_CUSTOM+EVENT_BECOME_SHIELD_TRIGGER)
	c:RegisterEffect(e4)
end
function Auxiliary.CastSpellCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if c:IsCanCastFree() then return true end
	local cost=c:GetPlayCost()
	local civ_count=c:GetCivilizationCount()
	local g=Duel.GetMatchingGroup(Auxiliary.PayManaFilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()<cost or civ_count>cost then return false end
	local b1=g:IsExists(Card.IsCivilization,1,nil,c:GetFirstCivilization())
	local b2=g:IsExists(Card.IsCivilization,1,nil,c:GetSecondCivilization())
	local b3=g:IsExists(Card.IsCivilization,1,nil,c:GetThirdCivilization())
	local b4=g:IsExists(Card.IsCivilization,1,nil,c:GetFourthCivilization())
	local b5=g:IsExists(Card.IsCivilization,1,nil,c:GetFifthCivilization())
	if chk==0 then
		if civ_count==1 then
			return b1
		elseif civ_count==2 then
			return b1 and b2
		elseif civ_count==3 then
			return b1 and b2 and b3
		elseif civ_count==4 then
			return b1 and b2 and b3 and b4
		elseif civ_count==5 then
			return b1 and b2 and b3 and b4 and b5
		end
	end
	Auxiliary.PayManaSelect(g,tp,c,cost,civ_count)
end

--functions for non-trigger abilities
--"When this creature would be destroyed, ABILITY."
--e.g. "Chilias, the Oracle" (DM-01 1/110), "Coiling Vines" (DM-01 92/110), "Aless, the Oracle" (DM-03 2/55)
function Auxiliary.AddSingleReplaceEffectDestroy(c,desc_id,targ_func,op_func,con_func)
	--c: the card that has the non-trigger ability
	--targ_func: target function (targ_func or Auxiliary.SingleReplaceDestroyTarget)
	--op_func: operation function (op_func or Auxiliary.SingleReplaceDestroyOperation)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetTarget(targ_func)
	if op_func then e1:SetOperation(op_func) end
	c:RegisterEffect(e1)
end
function Auxiliary.SingleReplaceDestroyTarget(f,...)
	--f: Card.IsAbleToX
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				if chk==0 then return not c:IsReason(REASON_REPLACE) and (not f or f(c,table.unpack(ext_params))) end
				return true
			end
end
function Auxiliary.SingleReplaceDestroyOperation(f,...)
	--f: Duel.SendtoX
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
				f(c,table.unpack(ext_params))
			end
end
--target for "When this creature would be destroyed, you may ABILITY."
--e.g. "Aqua Agent" (DM-07 16/55)
function Auxiliary.SingleReplaceDestroyTarget2(desc_id,f,...)
	--f: Card.IsAbleToX
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				if chk==0 then return not c:IsReason(REASON_REPLACE) and (not f or f(c,table.unpack(ext_params))) end
				if Duel.SelectYesNo(tp,aux.Stringid(c:GetOriginalCode(),desc_id)) then
					return true
				else return false end
			end
end
--"When one of your creatures would be destroyed, ABILITY."
--e.g. "King Ambergris" (Game Original)
function Auxiliary.AddReplaceEffectDestroy(c,desc_id,targ_func,op_func,val)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(targ_func)
	e1:SetValue(val)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--"If this creature would be discarded from your hand, ABILITY."
--e.g. "Dava Torey, Seeker of Clouds" (DM-06 18/110)
function Auxiliary.AddSingleReplaceEffectDiscard(c,desc_id,targ_func,op_func,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_HAND)
	if con_func then e1:SetCondition(con_func) end
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--"Whenever this creature would break a shield, BREAK REPLACE ABILITY."
--e.g. "Bolmeteus Steel Dragon" (DM-06 S7/S10)
function Auxiliary.AddReplaceEffectBreakShield(c,location)
	--location: where to send the shield (e.g. LOCATION_GRAVE)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BREAK_SHIELD_REPLACE)
	e1:SetValue(location)
	c:RegisterEffect(e1)
end
--"When this creature would leave the battle zone, ABILITY."
--e.g. "Soul Phoenix, Avatar of Unity" (DM-12 5/55)
--Not fully implemented: The effect of leaving the battle zone is not replaced
function Auxiliary.AddSingleReplaceEffectLeaveBZone(c,desc_id,op_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_BZONE)
	e1:SetCondition(Auxiliary.SelfLeaveBZoneCondition)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_EVOLUTION_SOURCE_REMAIN)
end
--"This creature can't attack, unless COST."
--e.g. "Daidalos, General of Fury" (DM-06 S5/S10)
function Auxiliary.AddAttackCost(c,cost_func,op_func)
	--cost_func: cost function
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(cost_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--EFFECT_TYPE_SINGLE trigger abilities
--code: EVENT_COME_INTO_PLAY for "When you put this creature into the battle zone" (e.g. "Miele, Vizier of Lightning" DM-01 13/110)
--code: EVENT_ATTACK_ANNOUNCE for "Whenever this creature attacks" (e.g. "Laguna, Lightning Enforcer" DM-02 4/55)
--code: EVENT_CUSTOM+EVENT_BLOCK for "Whenever this creature blocks" (e.g. "Spiral Grass" DM-02 10/55)
--code: EVENT_CUSTOM+EVENT_ATTACK_PLAYER for "When this creature attacks a player" (e.g. "Marrow Ooze, the Twister" DM-02 32/55)
--code: EVENT_DESTROYED for "When this creature is destroyed" (e.g. "Bombersaur" DM-02 36/55)
--code: EVENT_CUSTOM+EVENT_BECOME_BLOCKED for "Whenever this creature becomes blocked" (e.g. "Avalanche Giant" DM-05 S5/S5)
--code: EVENT_BE_BATTLE_TARGET for "Whenever this creature is attacked" (e.g. "Scalpel Spider" DM-07 32/55)
--code: EVENT_BATTLE_CONFIRM for "Whenever this creature is attacking and isn't blocked" (e.g. "Balesk Baj, the Timeburner" DM-09 4/55)
--code: EVENT_ATTACK_END for "after the battle [that includes this creature]" (e.g. "Bye Bye Amoeba" DM-13 40/55)
--code: EVENT_ATTACK_END for "after this creature attacks" (e.g. "Entropy Giant" Game Original)
--con_func: aux.UnblockedCondition for "Whenever this creature is attacking and isn't blocked" (e.g. "Balesk Baj, the Timeburner" DM-09 4/55)
function Auxiliary.AddSingleTriggerEffect(c,desc_id,code,optional,targ_func,op_func,prop,con_func)
	--optional: true for optional ("you may") abilities
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	if con_func then e1:SetCondition(con_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--EFFECT_TYPE_FIELD trigger abilities
--code: EVENT_PHASE+PHASE_END for "At the end of [the] turn" (e.g. "Frei, Vizier of Air" DM-01 4/110)
--code: EVENT_COME_INTO_PLAY for "Whenever another creature is put into the battle zone" (e.g. "Mist Rias, Sonic Guardian" DM-04 13/55)
--code: EVENT_DESTROYED for "Whenever another creature is destroyed" (e.g. "Mongrel Man" DM-04 33/55)
--code: EVENT_TO_GRAVE for "Whenever a card is put into your graveyard" (e.g. "Snork La, Shrine Guardian" DM-05 13/55)
--code: EVENT_COME_INTO_PLAY for "Whenever [a player] summons a creature" (e.g. "Aqua Rider" DM-06 31/110)
--code: EVENT_DRAW for "Whenever [a player] draws a card" (e.g. "Cosmic Nebula" DM-07 S2/S5)
--code: EVENT_ATTACK_ANNOUNCE for "Whenever any of your creatures attacks" (e.g. "Thrumiss, Zephyr Guardian" DM-08 15/55)
--code: EVENT_BE_BATTLE_TARGET "Whenever one of your creatures is attacked" (e.g. "Bubble Scarab" DM-10 81/110)
--code: EVENT_CUSTOM+EVENT_BLOCK for "Whenever one of your creatures blocks" (e.g. "Agira, the Warlord Crawler" DM-12 16/55)
--code: EVENT_BATTLE_CONFIRM for "Whenever any of your creatures is attacking and isn't blocked" (e.g. "Nemonex, Bajula's Robomantis" DM-12 19/55)
--code: EVENT_DISCARD for "Whenever [a player] discards cards" (e.g. "Dorothea, the Explorer" DM-13 6/55)
--code: EVENT_UNTAP_STEP for "At the start of [the] turn" (e.g. "Altimeth, Holy Divine Dragon" Game Original)
--code: EVENT_CUSTOM+EVENT_BREAK_SHIELD for "Whenever this creature breaks a shield" (e.g. "Bolblaze Dragon" Game Original)
--con_func: aux.EnterGraveCondition for "Whenever a card is put into your graveyard" (e.g. "Snork La, Shrine Guardian" DM-05 13/55)
--con_func: aux.PlayerSummonCreatureCondition(PLAYER_OPPO) for "Whenever your opponent summons a creature" (e.g. "Aqua Rider" DM-06 31/110)
--con_func: aux.EventPlayerCondition(PLAYER_SELF) for "Whenever you draw the card" (e.g. "Cosmic Nebula" DM-07 S2/S5)
--con_func: aux.UnblockedCondition for "Whenever any of your creatures is attacking and isn't blocked" (e.g. "Nemonex, Bajula's Robomantis" DM-12 19/55)
--con_func: aux.EventPlayerCondition(PLAYER_SELF) for "Whenever you discard cards" (e.g. "Dorothea, the Explorer" DM-13 6/55)
function Auxiliary.AddTriggerEffect(c,desc_id,code,optional,targ_func,op_func,prop,con_func)
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e1:SetRange(LOCATION_BZONE)
	if code==EVENT_PHASE+PHASE_END or code==EVENT_UNTAP_STEP then
		e1:SetCountLimit(1)
	end
	if con_func then e1:SetCondition(con_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--EFFECT_TYPE_SINGLE static abilities that provide a trigger effect
--code: EVENT_ATTACK_ANNOUNCE for "Whenever this creature attacks" (e.g. "Split-Head Hydroturtle Q" DM-05 24/55)
--code: EVENT_COME_INTO_PLAY for "When you put this creature into the battle zone" (e.g. "Forbos, Sanctum Guardian Q" DM-06 19/110)
function Auxiliary.AddSingleGrantTriggerEffect(c,desc_id,code,optional,targ_func1,op_func,prop,s_range,o_range,targ_func2)
	--targ_func1: target function (include aux.HintTarget)
	--s_range: the location of your creature to provide the ability to
	--o_range: the location of your opponent's creature to provide the ability to
	--targ_func2: target function for a specified creature to provide the ability to
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(code)
	e1:SetProperty(prop)
	if targ_func1 then e1:SetTarget(targ_func1) end
	e1:SetOperation(op_func)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	if targ_func2 then e2:SetTarget(targ_func2) end
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--EFFECT_TYPE_FIELD static abilities that provide a trigger effect
--code: EVENT_PHASE+PHASE_END for "At the end of [the] turn" (e.g. "Ballus, Dogfight Enforcer Q" DM-05 6/55)
function Auxiliary.AddGrantTriggerEffect(c,desc_id,code,optional,targ_func1,op_func,prop,s_range,o_range,targ_func2,con_func)
	--targ_func1: include aux.HintTarget
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(code)
	e1:SetProperty(prop)
	e1:SetRange(LOCATION_BZONE)
	if code==EVENT_PHASE+PHASE_END then
		e1:SetCountLimit(1)
	end
	if con_func then e1:SetCondition(con_func) end
	if targ_func1 then e1:SetTarget(targ_func1) end
	e1:SetOperation(op_func)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	if targ_func2 then e2:SetTarget(targ_func2) end
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--"Whenever a player uses the "shield trigger" ability of one of their shields, ABILITY."
--e.g. "Emperor Quazla" (DM-08 S2/S5), "Glena Vuele, the Hypnotic" (DM-09 1/55)
function Auxiliary.AddTriggerEffectPlayerUseShieldTrigger(c,desc_id,p,optional,targ_func,op_func)
	--p: the player who uses the ability (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetLabelObject():SetLabel(0)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(Auxiliary.STChainSolvedOperation(p))
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e3:SetType(EFFECT_TYPE_FIELD+typ)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetLabel()==1
	end)
	if targ_func then e3:SetTarget(targ_func) end
	e3:SetOperation(op_func)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
function Auxiliary.STChainSolvedOperation(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local reason_player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if reason_player and rp==reason_player
					and re:IsHasCategory(CATEGORY_SHIELD_TRIGGER) and re:GetHandler():IsBrokenShield() then
					e:GetLabelObject():SetLabel(1)
				end
			end
end
--"Whenever a player casts a spell, ABILITY."
--e.g. "Natalia, Channeler of Suns" (Game Original)
function Auxiliary.AddTriggerEffectPlayerCastSpell(c,desc_id,p,f,optional,targ_func,op_func,prop)
	--p: the player who casts the spell (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	--f: filter function if the spell is specified
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetLabelObject():SetLabel(0)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(Auxiliary.SpellChainSolvedOperation(p,f))
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e3:SetType(EFFECT_TYPE_FIELD+typ)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetLabel()==1
	end)
	if targ_func then e3:SetTarget(targ_func) end
	e3:SetOperation(op_func)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
function Auxiliary.SpellChainSolvedOperation(p,f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local reason_player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local rc=re:GetHandler()
				if reason_player and rp==reason_player and rc:IsSpell() and (not f or f(rc)) then
					e:GetLabelObject():SetLabel(1)
				end
			end
end
--"When this creature leaves the battle zone, ABILITY."
--e.g. "Wise Starnoid, Avatar of Hope" (DM-12 S2/S5)
--Not fully implemented: Ability does not trigger when the creature is added to the shields face down
function Auxiliary.AddSingleTriggerEffectLeaveBZone(c,desc_id,optional,targ_func,op_func,prop,con_func)
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(EVENT_LEAVE_BZONE)
	e1:SetProperty(prop)
	e1:SetCondition(aux.AND(Auxiliary.SelfLeaveBZoneCondition,con_func))
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--static ability that provides a continuous effect for a card
--e.g. "Dia Nork, Moonlight Guardian" (DM-01 2/110), "Brawler Zyler" (DM-01 70/110), "Deadly Fighter Braid Claw" (DM-01 74/110)
function Auxiliary.EnableEffectCustom(c,code,con_func,s_range,o_range,targ_func,val)
	--code: EFFECT_BLOCKER, EFFECT_POWER_ATTACKER, EFFECT_MUST_ATTACK, etc.
	--s_range: the location of your card to provide the ability to
	--o_range: the location of your opponent's card to provide the ability to
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	if con_func then e1:SetCondition(con_func) end
	if val then e1:SetValue(val) end
	c:RegisterEffect(e1)
end
--add a temporary ability to a card
--e.g. "Chaos Strike" (DM-01 72/110), "Diamond Cutter" (DM-02 1/55), "Rumble Gate" (DM-02 44/55)
function Auxiliary.AddTempEffectCustom(c,tc,desc_id,code,reset_flag,reset_count)
	--c: the card that provides the ability
	--tc: the card to provide the ability to
	--code: EFFECT_UNTAPPED_BE_ATTACKED, EFFECT_IGNORE_SUMMONING_SICKNESS, EFFECT_ATTACK_UNTAPPED, etc.
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--static ability that provides a continuous effect for a player
--e.g. "Alcadeias, Lord of Spirits" (DM-04 1/55), "Kyuroro" (DM-06 36/110)
function Auxiliary.EnablePlayerEffectCustom(c,code,s_range,o_range,val,con_func)
	--code: EFFECT_CANNOT_ACTIVATE, EFFECT_CHANGE_SHIELD_BREAK_PLAYER, etc.
	--s_range: 1 to provide the ability for you, or 0 not to
	--o_range: 1 to provide the ability for your opponent, or 0 not to
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(s_range,o_range)
	if con_func then e1:SetCondition(con_func) end
	if val then e1:SetValue(val) end
	c:RegisterEffect(e1)
end
--functions for non-keyworded abilities
--"This creature can't attack players."
--e.g. "Dia Nork, Moonlight Guardian" (DM-01 2/110)
function Auxiliary.EnableCannotAttackPlayer(c)
	Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_PLAYER,Auxiliary.CannotAttackPlayerCondition)
end
function Auxiliary.CannotAttackPlayerCondition(e)
	return not e:GetHandler():IsHasEffect(EFFECT_IGNORE_CANNOT_ATTACK_PLAYER)
end
--"This creature gets +/-N000 power."
--"Each of your/your opponent's creatures gets +/-N000 power."
--e.g. "Iocant, the Oracle" (DM-01 8/110), "Barkwhip, the Smasher" (DM-02 45/55)
function Auxiliary.EnableUpdatePower(c,val,con_func,s_range,o_range,targ_func)
	--val: the amount of power to gain/lose
	--con_func: include aux.SelfAttackerCondition for "while this creature is attacking"
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"Each of your creatures has "This creature gets +/-N000 power"."
--e.g. "Smash Horn Q" (DM-05 55/55)
function Auxiliary.AddStaticEffectUpdatePower(c,val,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetValue(val)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--e.g. "Rumble Gate" (DM-02 44/55)
function Auxiliary.AddTempEffectUpdatePower(c,tc,desc_id,val,reset_flag,reset_count,con_func)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"At the end of each of your turns, you may untap this creature."
--e.g. "Ruby Grass" (DM-01 17/110)
function Auxiliary.EnableTurnEndSelfUntap(c,desc_id,con_func,forced)
	--forced: true for forced abilities
	desc_id=desc_id or 0
	local typ=forced and EFFECT_TYPE_TRIGGER_F or EFFECT_TYPE_TRIGGER_O
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	if con_func then
		e1:SetCondition(aux.AND(Auxiliary.TurnPlayerCondition(PLAYER_SELF),con_func))
	else
		e1:SetCondition(Auxiliary.TurnPlayerCondition(PLAYER_SELF))
	end
	if typ==EFFECT_TYPE_TRIGGER_O then
		e1:SetTarget(Auxiliary.SelfUntapTarget)
	end
	e1:SetOperation(Auxiliary.SelfUntapOperation())
	c:RegisterEffect(e1)
end
function Auxiliary.SelfUntapTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToUntap() end
end
function Auxiliary.SelfUntapOperation(ram)
	--ram: true for "untap this creature at random"
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if not c:IsAbleToUntap() or not c:IsFaceup() then return end
				if ram then
					local os=require('os')
					math.randomseed(os.time())
					local ct=math.random(0,1)
					if ct==0 then return end
				end
				Duel.Untap(c,REASON_EFFECT)
			end
end
--"At the end of each of your turns, destroy this creature."
--e.g. "Gnarvash, Merchant of Blood" (DM-06 57/110)
function Auxiliary.EnableTurnEndSelfDestroy(c,desc_id,con_func)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	if con_func then
		e1:SetCondition(aux.AND(Auxiliary.TurnPlayerCondition(PLAYER_SELF),con_func))
	else
		e1:SetCondition(Auxiliary.TurnPlayerCondition(PLAYER_SELF))
	end
	e1:SetOperation(Auxiliary.SelfDestroyOperation())
	c:RegisterEffect(e1)
end
--"At the end of your turn, [you may] return this creature to your hand."
--e.g. "Ganzo, Flame Fisherman" (Game Original)
function Auxiliary.EnableTurnEndSelfReturn(c,desc_id,con_func,optional)
	desc_id=desc_id or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	if con_func then
		e1:SetCondition(aux.AND(Auxiliary.TurnPlayerCondition(PLAYER_SELF),con_func))
	else
		e1:SetCondition(Auxiliary.TurnPlayerCondition(PLAYER_SELF))
	end
	if typ==EFFECT_TYPE_TRIGGER_O then e1:SetTarget(Auxiliary.SelfReturnTarget) end
	e1:SetOperation(Auxiliary.SelfReturnOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.SelfReturnTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
end
function Auxiliary.SelfReturnOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
	end
end
--"This creature can't be blocked."
--e.g. "Candy Drop" (DM-01 28/110)
function Auxiliary.EnableCannotBeBlocked(c,f,con_func)
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	e1:SetValue(Auxiliary.CannotBeBlockedValue(f))
	c:RegisterEffect(e1)
end
--f: filter function for "This creature can't be blocked by X creatures."
--e.g. "Stampeding Longhorn" (DM-01 104/110), "Calgo, Vizier of Rainclouds" (DM-05 7/55)
function Auxiliary.CannotBeBlockedValue(f)
	return	function(e,re,tp)
				return re:IsHasCategory(CATEGORY_BLOCKER) and (not f or f(e,re,tp))
			end
end
function Auxiliary.CannotBeBlockedBoolFunction(f,...)
	local ext_params={...}
	return	function(e,re,tp)
				return f(re:GetHandler(),table.unpack(ext_params))
			end
end
--"Each of your creatures has "This creature can't be blocked"."
--e.g. "King Nautilus" (DM-02 17/55)
function Auxiliary.AddStaticEffectCannotBeBlocked(c,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(Auxiliary.SelfAttackerCondition)
	e1:SetValue(Auxiliary.CannotBeBlockedValue())
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--e.g. "Laser Wing" (DM-01 11/110)
function Auxiliary.AddTempEffectCannotBeBlocked(c,tc,desc_id,val,con_func,reset_flag,reset_count)
	con_func=con_func or aux.TRUE
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	e1:SetValue(Auxiliary.CannotBeBlockedValue(val))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetCondition(con_func)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e2)
end
--"This creature can't attack."
--"Creatures can't attack."
--e.g. "Hunter Fish" (DM-01 31/110), "Nariel, the Oracle" (DM-08 11/55)
function Auxiliary.EnableCannotAttack(c,con_func,s_range,o_range,tg)
	con_func=con_func or aux.TRUE
	local targ_func=aux.AND(Auxiliary.CannotAttackTarget,tg)
	if s_range or o_range then
		Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK,con_func,s_range,o_range,targ_func)
	else
		Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK,aux.AND(Auxiliary.SelfCannotAttackCondition,con_func))
	end
end
function Auxiliary.SelfCannotAttackCondition(e)
	return not e:GetHandler():IsHasEffect(EFFECT_IGNORE_CANNOT_ATTACK)
end
function Auxiliary.CannotAttackTarget(e,c)
	return not c:IsHasEffect(EFFECT_IGNORE_CANNOT_ATTACK)
end
--"When this creature wins a battle, destroy it."
--"When this creature wins a battle, it is destroyed at random."
--e.g. "Bloody Squito" (DM-01 46/110), "Hanakage, Shadow of Transience" (Game Original)
function Auxiliary.EnableBattleWinSelfDestroy(c,desc_id,ram)
	--ram: true for "This creature is destroyed at random"
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(Auxiliary.SelfBattleWinCondition)
	e1:SetOperation(Auxiliary.SelfDestroyOperation(ram))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	e2:SetOperation(Auxiliary.SelfDestroyOperation(ram))
	c:RegisterEffect(e2)
end
function Auxiliary.SelfDestroyOperation(ram)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if Duel.GetAttacker()==c then Duel.Tap(c,REASON_RULE) end --fix creature not being tapped when attacking
				if not c:IsLocation(LOCATION_BZONE) or not c:IsFaceup() then return end
				if ram then
					local os=require('os')
					math.randomseed(os.time())
					local ct=math.random(0,1)
					if ct==0 then return end
				end
				Duel.Destroy(c,REASON_EFFECT)
			end
end
--"Whenever this creature wins a battle, [you may] untap this creature."
--e.g. "Mobile Saint Meermax" (DM-13 17/55)
function Auxiliary.EnableBattleWinSelfUntap(c,desc_id,forced)
	desc_id=desc_id or 0
	local typ=forced and EFFECT_TYPE_TRIGGER_F or EFFECT_TYPE_TRIGGER_O
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(Auxiliary.SelfBattleWinCondition)
	if typ==EFFECT_TYPE_TRIGGER_O then
		e1:SetTarget(Auxiliary.SelfUntapTarget)
	end
	e1:SetOperation(Auxiliary.SelfUntapOperation())
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE+typ)
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	if typ==EFFECT_TYPE_TRIGGER_O then
		e2:SetTarget(Auxiliary.SelfUntapTarget)
	end
	e2:SetOperation(Auxiliary.SelfUntapOperation())
	c:RegisterEffect(e2)
end
--"This creature can attack untapped creatures."
--"This creature can attack untapped CIVILIZATION creatures."
--"Each of your creatures in the battle zone can attack untapped creatures."
--e.g. "Gatling Skyterror" (DM-01 79/110), "Aeris, Flight Elemental" (DM-04 6/55), "Storm Javelin Wyvern" (Game Original)
function Auxiliary.EnableAttackUntapped(c,val,con_func,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_ATTACK_UNTAPPED)
	if con_func then e1:SetCondition(con_func) end
	if val then e1:SetValue(val) end
	c:RegisterEffect(e1)
end
--"A player's creatures/spells each cost N more/less to summon/cast."
--"Each creature costs N more/less to summon and each spell costs N more/less to cast."
--e.g. "Elf-X" (DM-02 46/55), "Milieus, the Daystretcher" (DM-04 12/55)
--Not fully implemented: "They can't cost less than 2+"
function Auxiliary.EnableUpdatePlayCost(c,val,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_HAND+LOCATION_BZONE)
	end
	e1:SetCode(EFFECT_UPDATE_PLAY_COST)
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"This creature can't attack creatures."
--e.g. "Dawn Giant" (DM-03 46/55)
function Auxiliary.EnableCannotAttackCreature(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(aux.TargetBoolFunction(Card.IsCreature))
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_CREATURE)
end
--"This creature can't be attacked"
--e.g. "Gulan Rias, Speed Guardian" (DM-04 10/55), "Misha, Channeler of Suns" (DM-08 10/55)
function Auxiliary.EnableCannotBeAttacked(c,f)
	--f: filter function for "This creature can't be attacked by X creatures."
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetValue(Auxiliary.CannotBeAttackedValue(f))
	c:RegisterEffect(e1)
end
function Auxiliary.CannotBeAttackedValue(f)
	return	function(e,c)
				return not f or f(e,c)
			end
end
--"When this creature battles, destroy it after the battle."
--e.g. "Vile Mulder, Wing of the Void" (DM-06 69/110)
function Auxiliary.EnableBattleEndSelfDestroy(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.SelfBattleEndCondition)
	e1:SetOperation(Auxiliary.SelfBattleEndOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.SelfBattleEndCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget()
end
function Auxiliary.SelfBattleEndOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
--"Whenever another creature would be destroyed, it stays in the battle zone instead."
--e.g. "Mihail, Celestial Elemental" (DM-09 12/55)
function Auxiliary.EnableCannotBeDestroyed(c,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_INDESTRUCTIBLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTIBLE_BATTLE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_INDESTRUCTIBLE_EFFECT)
	c:RegisterEffect(e3)
end
--"When this creature loses a battle, it isn't destroyed."
--e.g. "Amnis, Holy Elemental" (L3/6 Y1)
function Auxiliary.EnableCannotBeBattleDestroyed(c,val,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_INDESTRUCTIBLE_BATTLE)
	if val then
		e1:SetValue(val)
	else
		e1:SetValue(1)
	end
	c:RegisterEffect(e1)
end
--"Whenever your opponent would choose a creature in the battle zone, he can't choose this one."
--e.g. "Petrova, Channeler of Suns" (DM-09 S1/S5)
function Auxiliary.EnableCannotBeTargeted(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetValue(Auxiliary.tgoval)
	c:RegisterEffect(e1)
end
--"Each of your creatures in the battle zone is a RACE in addition to its other races."
--e.g. "Q-tronic Omnistrain" (L2 Y2)
function Auxiliary.EnableAddRace(c,racename,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_ADD_CREATURE_RACE)
	e1:SetValue(racename)
	c:RegisterEffect(e1)
	if not RaceList then RaceList={} end
	table.insert(RaceList,racename)
end
function Auxiliary.EnableAddRaceCategory(c,racecat,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_ADD_CREATURE_RACE_CATEGORY)
	e1:SetValue(racecat)
	c:RegisterEffect(e1)
	if not RaceCatList then RaceCatList={} end
	table.insert(RaceCatList,racecat)
end
--functions for keyworded abilities
--"Blocker (Whenever an opponent's creature attacks, you may tap this creature to stop the attack. Then the 2 creatures battle.)"
--"Whenever an opponent's CIVILIZATION1 or CIVILIZATION2 creature attacks, you may tap this creature to stop the attack. Then the 2 creatures battle."
--e.g. "Dia Nork, Moonlight Guardian" (DM-01 2/110), "Lurking Eel" (DM-05 18/55), "Sasha, Channeler of Suns" (DM-08 12/55)
function Auxiliary.EnableBlocker(c,con_func,desc,f)
	--desc: DESC_FN_BLOCKER for "Fire and nature blocker", DESC_DRAGON_BLOCKER for "Dragon blocker", etc.
	--f: filter function for "CIVILIZATION blocker" or "RACE blocker"
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	if desc then
		e1:SetDescription(desc)
	else
		e1:SetDescription(DESC_BLOCKER)
	end
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.BlockerCondition1(f),aux.NOT(Auxiliary.BlockerCondition2),con_func))
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	c:RegisterEffect(e1)
	--must block
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetProperty(0)
	e2:SetCondition(aux.AND(Auxiliary.BlockerCondition1(f),Auxiliary.BlockerCondition2,con_func))
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_BLOCKER)
	c:RegisterEffect(e3)
	Auxiliary.EnableEffectCustom(c,EFFECT_BLOCKER,con_func)
end
function Auxiliary.BlockerCondition1(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc1=Duel.GetAttackTarget()
				if tc1 and tc1==e:GetHandler() then return false end
				local tc2=Duel.GetAttacker()
				return tc2:GetControler()~=tp and (not f or f(tc2))
			end
end
function Auxiliary.BlockerCondition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_MUST_BLOCK)
end
function Auxiliary.BlockerCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToTap() and Duel.GetFlagEffect(tp,EFFECT_BLOCKER)==0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,EFFECT_BLOCKER,RESET_CHAIN,0,1)
end
function Auxiliary.BlockerTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBlock(tp) end
end
function Auxiliary.BlockerOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Tap(c,REASON_EFFECT)
	local tc=Duel.GetAttacker()
	if not tc or tc:IsStatus(STATUS_ATTACK_CANCELED) then return end
	Duel.Tap(tc,REASON_RULE) --fix creature not being tapped when attacking
	Duel.NegateAttack()
	--register Card.IsBlocked
	tc:RegisterFlagEffect(EFFECT_BLOCKED,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	--add blocked prompt
	Duel.Hint(HINT_OPSELECTED,1-tp,DESC_BLOCKED)
	--register Duel.GetBlocker
	c:RegisterFlagEffect(EFFECT_BLOCKER,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	--raise event for "Whenever this creature blocks"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_BLOCK,e,0,0,0,0)
	--raise event for "Whenever one of your creatures blocks"
	Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_BLOCK,e,0,0,0,0)
	--raise event for "Whenever this creature becomes blocked"
	Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,e,0,0,0,0)
	--raise event for "Whenever any of your creatures becomes blocked"
	Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,e,0,0,0,0)
	--check for "Whenever this creature blocks/becomes blocked, no battle happens. (Both creatures stay tapped.)"
	if not c:IsHasEffect(EFFECT_NO_BLOCK_BATTLE) and not tc:IsHasEffect(EFFECT_NO_BE_BLOCKED_BATTLE) then
		Duel.BreakEffect()
		Duel.DoBattle(tc,c)
	end
end
--"Each of your creatures has "Blocker"."
--e.g. "Sieg Balicula, the Intense" (DM-03 8/55), "Gallia Zohl, Iron Guardian Q" (DM-05 8/55)
function Auxiliary.AddStaticEffectBlocker(c,s_range,o_range,targ_func,con_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.BlockerCondition1(),aux.NOT(Auxiliary.BlockerCondition2)))
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	if con_func then e2:SetCondition(con_func) end
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--must block
	local e3=e1:Clone()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e3:SetProperty(0)
	e3:SetCondition(aux.AND(Auxiliary.BlockerCondition1(),Auxiliary.BlockerCondition2))
	local e4=e2:Clone()
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_BLOCKER)
	local e6=e2:Clone()
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
	Auxiliary.EnableEffectCustom(c,EFFECT_BLOCKER,nil,s_range,o_range,targ_func)
end
--e.g. "Full Defensor" (DM-04 9/55)
function Auxiliary.AddTempEffectBlocker(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.BlockerCondition1(),aux.NOT(Auxiliary.BlockerCondition2)))
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	--must block
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetProperty(0)
	e2:SetCondition(aux.AND(Auxiliary.BlockerCondition1(),Auxiliary.BlockerCondition2))
	tc:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_BLOCKER)
	tc:RegisterEffect(e3)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_BLOCKER,reset_flag,reset_count)
end
--"Shield trigger (When this spell is put into your hand from your shield zone, you may cast it immediately for no cost.)"
--"Shield trigger (When this creature is put into your hand from your shield zone, you may summon it immediately for no cost.)"
--e.g. "Holy Awe" (DM-01 6/110), "Amber Grass" (DM-04 7/55)
function Auxiliary.EnableShieldTrigger(c)
	Auxiliary.EnableEffectCustom(c,EFFECT_SHIELD_TRIGGER)
end
function Auxiliary.ShieldTriggerCondition1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_SHIELD_TRIGGER)
end
function Auxiliary.ShieldTriggerCondition2(e,tp,eg,ep,ev,re,r,rp)
	return Auxiliary.ShieldTriggerCondition1(e,tp,eg,ep,ev,re,r,rp) and e:GetLabel()==1 and e:GetHandler():IsBrokenShield()
end
function Auxiliary.ShieldTriggerSummonTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():DMIsSummonable() end
end
function Auxiliary.ShieldTriggerSummonOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoBZone(c,SUMMON_TYPE_NONEVOLVE,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
end
--"Power attacker +N000 (While attacking, this creature gets +N000 power.)"
--e.g. "Brawler Zyler" (DM-01 70/110)
function Auxiliary.EnablePowerAttacker(c,val,con_func)
	con_func=con_func or aux.TRUE
	Auxiliary.EnableUpdatePower(c,val,aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	Auxiliary.EnableEffectCustom(c,EFFECT_POWER_ATTACKER,con_func)
end
--"Each of your creatures has "Power attacker +N000"."
--e.g. "Überdragon Jabaha" (DM-03 43/55), "Terradragon Hulcoon Berga" (Game Original)
function Auxiliary.AddStaticEffectPowerAttacker(c,val,s_range,o_range,targ_func,con_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.SelfAttackerCondition)
	e1:SetValue(val)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	if con_func then e2:SetCondition(con_func) end
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_POWER_ATTACKER,nil,s_range,o_range,targ_func)
end
--e.g. "Burning Power" (DM-01 71/110)
function Auxiliary.AddTempEffectPowerAttacker(c,tc,desc_id,val,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	reset_count=reset_count or 1
	Auxiliary.AddTempEffectUpdatePower(c,tc,desc_id,val,reset_flag,reset_count,Auxiliary.SelfAttackerCondition)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_POWER_ATTACKER,reset_flag,reset_count)
end
--"Slayer (Whenever this creature battles, destroy the other creature after the battle.)"
--"CIVILIZATION1 and CIVILIZATION2 slayer (Whenever this creature battles a CIVILIZATION1 or CIVILIZATION2 creature, destroy the other creature after the battle.)"
--e.g. "Bone Assassin, the Ripper" (DM-01 47/110), "Gigakail" (DM-05 26/55)
function Auxiliary.EnableSlayer(c,con_func,desc,f)
	--desc: DESC_NL_SLAYER for "Nature and light slayer", etc.
	--f: filter function for "CIVILIZATION slayer"
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	if desc then
		e1:SetDescription(desc)
	else
		e1:SetDescription(DESC_SLAYER)
	end
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(aux.AND(Auxiliary.SlayerCondition(f),con_func))
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_SLAYER,con_func)
end
function Auxiliary.SlayerCondition(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=e:GetHandler():GetBattleTarget()
				e:SetLabelObject(tc)
				return tc and tc:IsRelateToBattle() and (not f or f(tc))
			end
end
function Auxiliary.SlayerOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--"Each of your creatures has "Slayer"."
--e.g. "Gigaling Q" (DM-05 27/55), "Frost Specter, Shadow of Age" (DM-06 54/110)
function Auxiliary.AddStaticEffectSlayer(c,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SLAYER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.SlayerCondition())
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_SLAYER,nil,s_range,o_range,targ_func)
end
--e.g. "Creeping Plague" (DM-01 49/110)
function Auxiliary.AddTempEffectSlayer(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SLAYER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.SlayerCondition())
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOGRAVE-RESET_LEAVE+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_SLAYER,-RESET_TOGRAVE-RESET_LEAVE+reset_flag,reset_count)
end
--"Breaker (This creature breaks N shields.)"
--"Each creature in the battle zone has "Breaker"."
--e.g. "Gigaberos" (DM-01 55/110), "Chaotic Skyterror" (DM-04 41/55)
function Auxiliary.EnableBreaker(c,code,con_func,s_range,o_range,targ_func)
	--code: EFFECT_DOUBLE_BREAKER, EFFECT_TRIPLE_BREAKER, EFFECT_QUATTRO_BREAKER, etc.
	con_func=con_func or aux.TRUE
	Auxiliary.EnableEffectCustom(c,EFFECT_BREAKER,con_func,s_range,o_range,targ_func)
	Auxiliary.EnableEffectCustom(c,code,con_func,s_range,o_range,targ_func)
end
--"Crew breaker—"RACE" (This creature breaks one more shield for each of your other "RACE" in the battle zone.)"
--e.g. "Q-tronic Gargantua" (DM-06 86/110)
function Auxiliary.EnableCrewBreaker(c,f)
	Auxiliary.EnableEffectCustom(c,EFFECT_BREAKER)
	Auxiliary.EnableEffectCustom(c,EFFECT_CREW_BREAKER,nil,nil,nil,nil,Auxiliary.CrewBreakerValue(f))
end
function Auxiliary.CrewBreakerValue(f)
	return	function(e,c)
				local filt_func=function(c,f)
					return c:IsFaceup() and (not f or f(c))
				end
				return Duel.GetMatchingGroupCount(filt_func,c:GetControler(),LOCATION_BZONE,0,c,f)
			end
end
--get the number of shields a creature breaks with "Crew Breaker"
function Auxiliary.GetCrewBreakerCount(c)
	local t={c:IsHasEffect(EFFECT_CREW_BREAKER)}
	local res=1
	for _,te in pairs(t) do
		if type(te:GetValue())=="function" then
			res=res+te:GetValue()(te,c)
		else
			res=res+te:GetValue()
		end
	end
	return res
end
--e.g. "Magma Gazer" (DM-01 81/110)
function Auxiliary.AddTempEffectBreaker(c,tc,desc_id,code,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	reset_count=reset_count or 1
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_BREAKER,reset_flag,reset_count)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,code,reset_flag,reset_count)
end
--"Instead of having this creature attack, you may tap it to use its Tap ability."
--e.g. "Tank Mutant" (DM-06 6/110)
function Auxiliary.EnableTapAbility(c,desc_id,targ_func,op_func,prop)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	if prop then e1:SetProperty(prop) end
	e1:SetRange(LOCATION_BZONE)
	e1:SetHintTiming(TIMING_ATTACK_STEP,0)
	e1:SetCondition(Auxiliary.TapAbilityCondition)
	e1:SetCost(Auxiliary.SelfTapCost)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
function Auxiliary.TapAbilityCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Auxiliary.BattlePhaseCondition() and c:IsCanUseTapAbility(tp) and Duel.GetCurrentChain()==0
		and Duel.GetAttacker()==nil and c:GetAttackAnnouncedCount()==0 and c:IsCanAttack()
end
--"Each of your creatures may tap instead of attacking to use this Tap ability."
--e.g. "Arc Bine, the Astounding" (DM-06 12/110)
function Auxiliary.AddStaticEffectTapAbility(c,desc_id,targ_func1,op_func,s_range,o_range,targ_func2,prop)
	--targ_func1: include aux.HintTarget
	desc_id=desc_id or 0
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func2=targ_func2 or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	if prop then e1:SetProperty(prop) end
	e1:SetRange(LOCATION_BZONE)
	e1:SetHintTiming(TIMING_ATTACK_STEP,0)
	e1:SetCondition(Auxiliary.TapAbilityCondition)
	e1:SetCost(Auxiliary.SelfTapCost)
	if targ_func1 then e1:SetTarget(targ_func1) end
	e1:SetOperation(op_func)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func2)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--"CIVILIZATION stealth (This creature can't be blocked while your opponent has any CIVILIZATION cards in his mana zone.)"
--e.g. "Kizar Basiku, the Outrageous" (DM-07 9/55)
function Auxiliary.EnableStealth(c,civ,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_STEALTH)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(civ)
	c:RegisterEffect(e1)
	Auxiliary.EnableCannotBeBlocked(c,nil,Auxiliary.StealthCondition(civ))
end
function Auxiliary.StealthCondition(civ)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				return Duel.IsExistingMatchingCard(Auxiliary.ManaZoneFilter(Card.IsCivilization),tp,0,LOCATION_MZONE,1,nil,civ)
			end
end
--"Turbo rush (If any of your other creatures broke any shields this turn, this creature gets its Turborush ability until the end of the turn.)"
--e.g. "Magmadragon Jagalzor" (DM-08 4/55)
function Auxiliary.EnableTurboRush(c,op_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TURBO_RUSH)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(TIMING_ATTACK_STEP,0)
	e1:SetCondition(Auxiliary.TurboRushCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
function Auxiliary.TurboRushCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBrokenShieldCount()==0 and Duel.GetBrokenShieldCount(tp)>0
		and Duel.GetCurrentChain()==0 and Duel.GetAttacker()==nil
end
--"Silent skill (After your other creatures untap, if this creature is tapped, you may keep it tapped instead and use its Silentskill ability.)"
--e.g. "Kejila, the Hidden Horror" (DM-10 5/110)
function Auxiliary.EnableSilentSkill(c,desc_id,targ_func,op_func,prop)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_UNTAP_STEP)
	if prop then e1:SetProperty(prop) end
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.SilentSkillCondition)
	e1:SetCost(Auxiliary.SilentSkillCost)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_SILENT_SKILL)
end
function Auxiliary.SilentSkillCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():IsTapped()
end
function Auxiliary.SilentSkillCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(EFFECT_SILENT_SKILL,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW,0,1)
end
--"Wave striker (While 2 or more other creatures in the battle zone have "wave striker," this creature has its Wavestriker ability.)"
--e.g. "Asra, Vizier of Safety" (DM-11 6/55)
function Auxiliary.EnableWaveStriker(c)
	Auxiliary.EnableEffectCustom(c,EFFECT_WAVE_STRIKER)
end
--condition for "Wave Striker"
--Note: Always include this function for the specified "Wave Striker" ability
function Auxiliary.WaveStrikerCondition(e)
	local f=function(c)
		return c:IsFaceup() and c:IsHasEffect(EFFECT_WAVE_STRIKER)
	end
	return Duel.IsExistingMatchingCard(f,e:GetHandlerPlayer(),LOCATION_BZONE,LOCATION_BZONE,2,e:GetHandler())
end
--"Sympathy: "RACE" (This creature/spell costs 1 less to summon/cast for each of your "RACE" creatures in the battle zone. It can't cost less than X.)"
--e.g. "Akashic First, Electro-Dragon" (DM-13 3/55)
--Not fully implemented: If a creature in the battle zone has both specified races listed, it can't count as both
--https://duelmasters.fandom.com/wiki/Dolgeza,_Veteran_of_Hard_Battle/Rulings
function Auxiliary.EnableSympathy(c,race1,race2)
	Auxiliary.EnableUpdatePlayCost(c,Auxiliary.SympathyValue(race1,race2))
	Auxiliary.EnableEffectCustom(c,EFFECT_SYMPATHY)
end
function Auxiliary.SympathyValue(race1,race2)
	return	function(e,c)
				local f1=function(c,race1)
					return c:IsFaceup() and c:DMIsRace(race1)
				end
				local f2=function(c,race2)
					return c:IsFaceup() and c:DMIsRace(race2)
				end
				local ct1=Duel.GetMatchingGroupCount(f1,0,LOCATION_BZONE,LOCATION_BZONE,nil,race1)
				local ct2=Duel.GetMatchingGroupCount(f2,0,LOCATION_BZONE,LOCATION_BZONE,nil,race2)
				return (ct1+ct2)*-1
			end
end
--"Shield Saver (When one of your shields would be broken, you may destroy this creature instead.)"
--e.g. "Balzark "Fire Blast" Dragon" (DM-30 15/55)
function Auxiliary.EnableShieldSaver(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SHIELD_SAVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(Auxiliary.ShieldSaverTarget(desc_id))
	e1:SetValue(Auxiliary.ShieldSaverValue)
	e1:SetOperation(Auxiliary.ShieldSaverOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.ShieldSaverFilter(c,tp)
	return c:IsLocation(LOCATION_SZONE) and c:IsControler(tp)
		and c:GetDestination()~=LOCATION_SZONE and not c:IsReason(REASON_REPLACE)
end
function Auxiliary.ShieldSaverTarget(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				if chk==0 then return eg:FilterCount(Auxiliary.ShieldSaverFilter,nil,tp)==1
					and bit.band(r,REASON_BREAK)~=0 and c:IsDestructable()
					and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
				return Duel.SelectYesNo(tp,aux.Stringid(c:GetOriginalCode(),desc_id))
			end
end
function Auxiliary.ShieldSaverValue(e,c)
	return Auxiliary.ShieldSaverFilter(c,e:GetHandlerPlayer())
end
function Auxiliary.ShieldSaverOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.Destroy(c,REASON_EFFECT+REASON_REPLACE)
end
--"RACE Hunter (This creature wins all battles against RACE.)"
--e.g. "Pearl Carras, Barrier Guardian" (Game Original)
function Auxiliary.EnableWinsAllBattles(c,desc_id,f)
	--f: filter function for "RACE Hunter"
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(Auxiliary.WinsAllBattlesCondition(f))
	e1:SetOperation(Auxiliary.WinsAllBattlesOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_WINS_ALL_BATTLES)
end
function Auxiliary.WinsAllBattlesCondition(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=e:GetHandler():GetBattleTarget()
				return tc and tc:IsFaceup() and tc:IsControler(1-tp) and (not f or f(tc))
			end
end
function Auxiliary.WinsAllBattlesOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local tc=c:GetBattleTarget()
	if c:IsHasEffect(EFFECT_WINS_ALL_BATTLES) and tc:IsHasEffect(EFFECT_WINS_ALL_BATTLES) then
		--neither creature is destroyed
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTIBLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		tc:RegisterEffect(e2)
	else
		--raise event for "When this creature wins a battle"
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
		--raise event for "Whenever one of your creatures wins a battle"
		Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
		--raise event for "When this creature loses a battle"
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
		--(reserved) raise event for "Whenever one of your creatures loses a battle"
		--Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
		Duel.Destroy(tc,REASON_RULE)
	end
end
--operation for abilities that target cards
--f: Duel.Destroy to destroy cards
--f: Duel.SendtoDeck to send cards to the deck
--f: Duel.DMSendtoGrave to discard cards (REASON_DISCARD+REASON_EFFECT)
--f: Duel.DMSendtoGrave to send cards to the graveyard
--f: Duel.SendtoMZone to send cards to the mana zone
--f: Duel.Tap to tap cards
--f: Duel.Untap to untap cards
function Auxiliary.TargetCardsOperation(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()>0 then
					f(g,table.unpack(ext_params))
				end
			end
end
--Shield Break
--operation for abilities that break shields
function Auxiliary.BreakOperation(sp,tgp,ct,rc,ignore_breaker)
	--rc: the creature that breaks the shield
	--sp,ct: nil to break all shields
	--ignore_breaker: true to not break a number of shields according to the breaker abilities rc may have
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sel_player=(sp==PLAYER_SELF and tp) or (sp==PLAYER_OPPO and 1-tp)
				local target_player=(tgp==PLAYER_SELF and tp) or (tgp==PLAYER_OPPO and 1-tp)
				rc=rc or e:GetHandler()
				if Duel.GetShieldCount(target_player)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.BreakShield(e,sel_player,target_player,ct,rc,REASON_EFFECT,ignore_breaker)
			end
end
--Shield Peek, Peeping
--operation for abilities that let a player look at cards that are not public knowledge
function Auxiliary.ConfirmOperation(p,f,s,o,min,max,ex,...)
	--f: include Card.IsFacedown for LOCATION_SZONE, not Card.IsPublic for LOCATION_HAND
	--p,min,max: nil to look at all cards
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(f,tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_CONFIRM)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.ConfirmCards(player,sg)
				else
					Duel.ConfirmCards(player,g)
				end
			end
end
--operation for abilities that target cards that are not public knowledge to let a player look at them
function Auxiliary.TargetConfirmOperation(turn_faceup)
	--turn_faceup: true to turn a shield face up
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()>0 then
					Duel.ConfirmCards(tp,g,turn_faceup)
				end
			end
end
--operation for abilities that let a player look at cards from the top of a player's deck
function Auxiliary.DecktopConfirmOperation(p,ct)
	--p: the player whose cards to look at (PLAYER_SELF or PLAYER_OPPO)
	--ct: the number of cards to look at
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local g=Duel.GetDecktopGroup(player,ct)
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.ConfirmCards(player,g)
			end
end
--Destroy
--operation for abilities that destroy cards
function Auxiliary.DestroyOperation(p,f,s,o,min,max,ram,ex,...)
	--p,min,max: nil to destroy all cards
	--ram: true to destroy cards at random
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(f,tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local sg=nil
				if min and max then
					if ram then
						sg=g:RandomSelect(player,min)
					else
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DESTROY)
						sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					end
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.Destroy(sg,REASON_EFFECT)
				else
					Duel.Destroy(g,REASON_EFFECT)
				end
			end
end
--Card Discard
--operation for abilities that discard cards
function Auxiliary.DiscardOperation(p,f,s,o,min,max,ram,ex,...)
	--p,min,max: nil to discard all cards
	--ram: true to discard cards at random
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(f,tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				local sg=nil
				if min and max then
					if ram then
						sg=g:RandomSelect(player,min)
					else
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
						sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					end
					Duel.DMSendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
				else
					Duel.DMSendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
				end
			end
end
--Card Draw
--target and operation functions for abilities that draw a specified number of cards
function Auxiliary.DrawTarget(p)
	--p: the player who draws the card (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanDraw(player,1) end
			end
end
function Auxiliary.DrawOperation(p,ct)
	--ct: the number of cards to draw
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanDraw(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.Draw(player,ct,REASON_EFFECT)
			end
end
--operation for abilities that draw up to a number of cards
--use Auxiliary.DrawTarget for the target function, if needed
function Auxiliary.DrawUpToOperation(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanDraw(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.DrawUpTo(player,ct,REASON_EFFECT)
			end
end
--Put Into Battle Zone
--target and operation functions for abilities that send cards to the battle zone
function Auxiliary.SendtoBZoneFilter(c,e,tp,f,...)
	return c:IsAbleToBZone(e,0,tp,false,false) and (not f or f(c,e,tp,...))
end
function Auxiliary.SendtoBZoneTarget(f,s,o,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then
					if s==LOCATION_DECK or o==LOCATION_DECK then
						return Duel.GetFieldGroupCount(tp,s,o)>0
					else
						return Duel.IsExistingMatchingCard(Auxiliary.SendtoBZoneFilter,tp,s,o,1,ex,e,tp,f,table.unpack(ext_params))
					end
				end
			end
end
function Auxiliary.SendtoBZoneOperation(p,f,s,o,min,max,pos,ex,...)
	--p,min,max: nil to send all cards to the battle zone
	--pos: POS_FACEUP_UNTAPPED for untapped position or POS_FACEUP_TAPPED for tapped position
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				pos=pos or POS_FACEUP_UNTAPPED
				local bzone_count=Duel.GetLocationCount(player,LOCATION_BZONE)
				if max>bzone_count then max=bzone_count end
				local g=Duel.GetMatchingGroup(Auxiliary.SendtoBZoneFilter,tp,s,o,ex,e,tp,f,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOBZONE)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					for sc in aux.Next(sg) do
						Duel.SendtoBZone(sc,0,player,sc:GetOwner(),false,false,pos)
					end
				else
					for tc in aux.Next(g) do
						Duel.SendtoBZone(tc,0,player,tc:GetOwner(),false,false,pos)
					end
				end
			end
end
--operation for abilities that target cards to send to the battle zone
function Auxiliary.TargetSendtoBZoneOperation(p,pos)
	--p: the player who sends the card to the battle zone (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()==0 then return end
				for tc in aux.Next(g) do
					Duel.SendtoBZone(tc,0,player,tc:GetOwner(),false,false,pos)
				end
			end
end
--Graveyard Feed
--operation for abilities that send cards to the graveyard
function Auxiliary.SendtoGraveOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to send all cards to the graveyard
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(aux.AND(Card.DMIsAbleToGrave,f),tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOGRAVE)
					local sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.DMSendtoGrave(sg,REASON_EFFECT)
				else
					Duel.DMSendtoGrave(g,REASON_EFFECT)
				end
			end
end
--Put Into Hand
--operation for abilities that send cards to the hand
function Auxiliary.SendtoHandOperation(p,f,s,o,min,max,conf,ex,...)
	--p,min,max: nil to send all cards to the hand
	--conf: true to show cards added from the deck to the opponent
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local desc=HINTMSG_RTOHAND
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToHand,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					if s==LOCATION_DECK or o==LOCATION_DECK then desc=HINTMSG_ATOHAND end
					Duel.Hint(HINT_SELECTMSG,player,desc)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
				else
					Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
				end
				local cffilter=function(c,p,loc)
					return c:IsControler(p) and c:IsPreviousLocation(loc)
				end
				local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_DECK)
				local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_DECK)
				local og3=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				local og4=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				--show cards taken from the deck only if the ability says to do so
				if conf and og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
				if conf and og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
				--show cards taken from the mana zone or graveyard by default
				if og3:GetCount()>0 then Duel.ConfirmCards(1-tp,og3) end
				if og4:GetCount()>0 then Duel.ConfirmCards(tp,og4) end
			end
end
--operation for abilities that target cards to send to the hand
function Auxiliary.TargetSendtoHandOperation(conf,use_shield_trigger)
	--conf: true to show cards added from the deck to the opponent
	--use_shield_trigger: true if the controller of the returned card can use its "shield trigger" ability
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()==0 or Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT,use_shield_trigger)==0 then return end
				local cffilter=function(c,p,loc)
					return c:IsControler(p) and c:IsPreviousLocation(loc)
				end
				local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_DECK)
				local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_DECK)
				local og3=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				local og4=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				--show cards taken from the deck only if the ability says to do so
				if conf and og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
				if conf and og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
				--show cards taken from the mana zone or graveyard by default
				if og3:GetCount()>0 then Duel.ConfirmCards(1-tp,og3) end
				if og4:GetCount()>0 then Duel.ConfirmCards(tp,og4) end
			end
end
--Mana Feed
--operation for abilities that send cards to the mana zone (untapped)
function Auxiliary.SendtoMZoneOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to send all cards to the mana zone
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToMZone,f),tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOMZONE)
					local sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.SendtoMZone(sg,POS_FACEUP_UNTAPPED,REASON_EFFECT)
				else
					Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
				end
			end
end
--target and operation functions for abilities that send cards from the top of a player's deck to the mana zone (untapped)
function Auxiliary.DecktopSendtoMZoneTarget(p)
	--p: the player whose cards to send to the mana zone (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanSendDecktoptoMZone(player,1) end
			end
end
function Auxiliary.DecktopSendtoMZoneOperation(p,ct)
	--ct: the number of cards to send to the mana zone
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanSendDecktoptoMZone(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.SendDecktoptoMZone(player,ct,POS_FACEUP_UNTAPPED,REASON_EFFECT)
			end
end
--Shield Feed
--operation for abilities that send cards to the shield zone
function Auxiliary.SendtoSZoneOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to send all cards to the shield zone
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local szone_count=Duel.GetLocationCount(player,LOCATION_SZONE)
				if max>szone_count then max=szone_count end
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToSZone,f),tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOSZONE)
					local sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.SendtoSZone(sg)
				else
					Duel.SendtoSZone(g)
				end
				local cffilter=function(c,p,loc)
					return c:IsControler(p) and c:IsPreviousLocation(loc)
				end
				local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
				--show cards taken from the mana zone or graveyard by default
				if og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
				if og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
			end
end
--operation for abilities that target cards to send to the shield zone
function Auxiliary.TargetSendtoSZoneOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 or Duel.SendtoSZone(g)==0 then return end
	local cffilter=function(c,p,loc)
		return c:IsControler(p) and c:IsPreviousLocation(loc)
	end
	local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
	local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_GRAVE)
	--show cards taken from the mana zone or graveyard by default
	if og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
	if og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
end
--target and operation functions for abilities that send cards from the top of a player's deck to the shield zone
function Auxiliary.DecktopSendtoSZoneTarget(p)
	--p: the player whose cards to send to the shield zone (PLAYER_SELF, PLAYER_OPPO, or PLAYER_ALL)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				if chk==0 then
					local b1=Duel.IsPlayerCanSendDecktoptoSZone(player1,1)
					local b2=Duel.IsPlayerCanSendDecktoptoSZone(player2,1)
					if p==PLAYER_ALL then
						return b1 or b2
					else
						return b1
					end
				end
			end
end
function Auxiliary.DecktopSendtoSZoneOperation(p,ct)
	--ct: the number of cards to send to the shield zone
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				if not Duel.IsPlayerCanSendDecktoptoSZone(player1,1)
					and not Duel.IsPlayerCanSendDecktoptoSZone(player2,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.SendDecktoptoSZone(player1,ct)
				if p==PLAYER_ALL then
					Duel.SendDecktoptoSZone(player2,ct)
				end
			end
end
--operation for abilities that send up to a number of cards from the top of a player's deck to the shield zone
function Auxiliary.DecktopSendtoSZoneUpToOperation(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanSendDecktoptoSZone(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.SendDecktoptoSZoneUpTo(player,ct)
			end
end
--Sort
--operation for abilities that let a player look at the top cards of a player's deck and return them in any order
--use Auxiliary.CheckDeckFunction for the target function, if needed
function Auxiliary.SortDecktopOperation(sortp,tgp,ct)
	--sortp: the player who sorts the cards (PLAYER_SELF or PLAYER_OPPO)
	--tgp: the player whose deck to sort the cards from (PLAYER_SELF or PLAYER_OPPO)
	--ct: the number of cards to sort
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sort_player=(sortp==PLAYER_SELF and tp) or (sortp==PLAYER_OPPO and 1-tp)
				local target_player=(tgp==PLAYER_SELF and tp) or (tgp==PLAYER_OPPO and 1-tp)
				if Duel.GetFieldGroupCount(target_player,LOCATION_DECK,0)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local g=Duel.GetDecktopGroup(target_player,ct)
				Duel.SortDecktop(sort_player,target_player,ct)
			end
end
--Tap, Untap
--operation for abilities that tap cards
function Auxiliary.TapOperation(p,f,s,o,min,max,ram,ex,...)
	--p,min,max: nil to tap all cards
	--ram: true to tap cards at random
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToTap,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local tc=Duel.GetAttacker()
				if tc and tc:IsAbleToTap() then Duel.Tap(tc,REASON_RULE) end --fix creature not being tapped when attacking
				local sg=nil
				if min and max then
					if ram then
						sg=g:RandomSelect(player,min)
					else
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TAP)
						sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					end
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.Tap(sg,REASON_EFFECT)
				else
					Duel.Tap(g,REASON_EFFECT)
				end
			end
end
--operation for abilities untap cards
function Auxiliary.UntapOperation(p,f,s,o,min,max,ram,ex,...)
	--p,min,max: nil to untap all cards
	--ram: true to untap cards at random
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToUntap,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local tc=Duel.GetAttacker()
				if tc and tc:IsAbleToTap() then Duel.Tap(tc,REASON_RULE) end --fix creature not being tapped when attacking
				local sg=nil
				if min and max then
					if ram then
						sg=g:RandomSelect(player,min)
					else
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_UNTAP)
						sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					end
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.Untap(sg,REASON_EFFECT)
				else
					Duel.Untap(g,REASON_EFFECT)
				end
			end
end

--condition to check if the current phase is the battle phase
function Auxiliary.BattlePhaseCondition()
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
--condition to check who the turn player is
function Auxiliary.TurnPlayerCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetTurnPlayer()==player
			end
end
--condition to check who the event player is
function Auxiliary.EventPlayerCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return ep==player
			end
end
--condition to check who the reason player is
function Auxiliary.ReasonPlayerCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return rp==player
			end
end
--condition to check if a player has a particular card in a location
--e.g. "Iocant, the Oracle" (DM-01 Iocant, the Oracle 8/110)
function Auxiliary.ExistingCardCondition(f,s,o,count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				f=f or aux.TRUE
				s=s or LOCATION_BZONE
				o=o or 0
				count=count or 1
				return Duel.IsExistingMatchingCard(f,e:GetHandlerPlayer(),s,o,count,nil)
			end
end
--condition of "While this creature is attacking"
--e.g. "Bolshack Dragon" (DM-01 69/110)
function Auxiliary.SelfAttackerCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
--condition of "Whenever this creature is attacked"
--e.g. "Scalpel Spider" (DM-07 32/55)
function Auxiliary.SelfAttackTargetCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler()
end
--condition to check the creature that is attacked
--e.g. "Akashic Third, the Electro-Bandit" (DM-13 19/55)
function Auxiliary.AttackTargetCondition(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=Duel.GetAttackTarget()
				return tc and tc:IsFaceup() and (not f or f(tc))
			end
end
--condition of "While this creature is battling"
--e.g. "Sasha, Channeler of Suns" (DM-08 12/55)
function Auxiliary.SelfBattlingCondition(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local tc=Duel.GetAttackTarget()
				return (Duel.GetAttacker()==c or tc==c) and c:IsRelateToBattle() and (not f or f(tc))
			end
end
--condition of "Whenever this creature blocks [...] after the battle" + EVENT_ATTACK_END
--e.g. "Spiral Grass" (DM-02 10/55)
function Auxiliary.SelfBlockCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBlocker()==e:GetHandler()
end
--condition of "Whenever this creature wins a battle" + EVENT_BATTLE_DESTROYING
--e.g. "Bloody Squito" (DM-01 46/110), "Hanakage, Shadow of Transience" (Game Original)
function Auxiliary.SelfBattleWinCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:IsLocation(LOCATION_BZONE)
end
--condition to check if a creature has left the battle zone
--e.g. "Bombersaur" (DM-02 36/55), "Altimeth, Holy Divine Dragon" (Game Original)
function Auxiliary.SelfLeaveBZoneCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_BZONE)
end
--condition of "While this creature is tapped"
--e.g. "Barkwhip, the Smasher" (DM-02 45/55)
function Auxiliary.SelfTappedCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsTapped()
end
--condition of "While this creature is untapped"
--e.g. "Ulex, the Dauntless" (DM-10 104/110)
function Auxiliary.SelfUntappedCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsUntapped()
end
--condition of "While all the cards in your mana zone are CIVILIZATION cards"
--e.g. "Sparkle Flower" (DM-03 9/55)
function Auxiliary.MZoneExclusiveCondition(f,...)
	local ext_params={...}
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local filt_func=function(c,f,...)
					return not f(c,...)
				end
				return Duel.IsExistingMatchingCard(Auxiliary.ManaZoneFilter(),tp,LOCATION_MZONE,0,1,nil,f,table.unpack(ext_params))
					and not Duel.IsExistingMatchingCard(Auxiliary.ManaZoneFilter(filt_func),tp,LOCATION_MZONE,0,1,nil,f,table.unpack(ext_params))
			end
end
--condition of "When a card is put into your graveyard" + EVENT_TO_GRAVE
--e.g. "Snork La, Shrine Guardian" (DM-05 13/55)
function Auxiliary.EnterGraveCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local f=function(c,player)
					if player then
						return c:IsControler(player)
					else return true end
				end
				return eg:IsExists(Auxiliary.DMGraveFilter(f),1,nil,player)
			end
end
--condition for a player having no shields
--e.g. "Gigazoul" (DM-05 28/55)
function Auxiliary.NoShieldsCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetShieldCount(player)==0
			end
end
--condition for a player having no cards in their hand
--e.g. "Headlong Giant" (DM-07 S5/S5)
function Auxiliary.NoHandCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetFieldGroupCount(player,LOCATION_HAND,0)==0
			end
end
--condition to check which player summoned the summoned creature
--e.g. "Aqua Rider" (DM-06 31/110)
function Auxiliary.PlayerSummonCreatureCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local f=function(c,sp)
					if not c:IsSummonType(SUMMON_TYPE_NONEVOLVE) then return false end
					return sp and c:GetSummonPlayer()==sp
				end
				return eg:IsExists(f,1,nil,player)
			end
end
--condition to check if a creature is attacking a player
--e.g. "Solar Grass" (DM-08 14/55)
function Auxiliary.AttackPlayerCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
--condition to check if the attacking creature isn't blocked + EVENT_BATTLE_CONFIRM
--e.g. "Solar Grass" (DM-08 14/55)
function Auxiliary.UnblockedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and not tc:IsBlocked()
end
--cost for a card tapping itself
--e.g. "Millstone Man" (Game Original)
function Auxiliary.SelfTapCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToTap() end
	Duel.Tap(c,REASON_COST)
end
--target for a continuous effect that is active to cards other than the card with the continuous effect
function Auxiliary.TargetBoolFunctionExceptSelf(f,...)
	local ext_params={...}
	return	function(effect,target)
				return target~=effect:GetHandler() and (not f or f(target,table.unpack(ext_params)))
			end
end
--target for optional trigger abilities that do not target cards
function Auxiliary.CheckCardFunction(f,s,o,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				if chk==0 then return Duel.IsExistingMatchingCard(f,tp,s,o,1,exg,table.unpack(ext_params)) end
			end
end
--target for trigger abilities that target cards
function Auxiliary.TargetCardFunction(p,f,s,o,min,max,desc,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				desc=desc or HINTMSG_TARGET
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex)
				elseif type(ex)=="function" then
					exg=ex(e,tp,eg,ep,ev,re,r,rp)
				end
				if chkc then
					if min>1 then return false end
					if not chkc:IsLocation(s+o) then return false end
					if s==0 and o>0 and chkc:IsControler(tp) then return false end
					if o==0 and s>0 and chkc:IsControler(1-tp) then return false end
					if f and not f(chkc,e,tp,eg,ep,ev,re,r,rp) then return false end
					if exg:GetCount()>0 and exg:IsContains(chkc) then return false end
					return true
				end
				if chk==0 then
					if e:IsHasType(EFFECT_TYPE_TRIGGER_F) or e:IsHasType(EFFECT_TYPE_QUICK_F) or c:IsSpell() then return true end
					return Duel.IsExistingTarget(f,tp,s,o,1,exg,table.unpack(ext_params))
				end
				Duel.Hint(HINT_SELECTMSG,player,desc)
				Duel.SelectTarget(player,f,tp,s,o,min,max,exg,table.unpack(ext_params))
			end
end
--target to check if a player has cards in their deck
function Auxiliary.CheckDeckFunction(p)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.GetFieldGroupCount(player,LOCATION_DECK,0)>0 end
			end
end
--target for Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
function Auxiliary.HintTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		if chkc then return false end
	end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--filter for a face up creature in the battle zone
--reserved
--[[
function Auxiliary.FaceupFilter(f,...)
	local ext_params={...}
	return	function(target)
				return target:IsFaceup() and f(target,table.unpack(ext_params))
			end
end
]]
--filter for a card in the mana zone
function Auxiliary.ManaZoneFilter(f)
	return	function(target,...)
				return target:IsMana() and (not f or f(target,...))
			end
end
--filter for a card in the graveyard
function Auxiliary.DMGraveFilter(f)
	return	function(target,...)
				return target:IsGrave() and (not f or f(target,...))
			end
end
--filter for a card in the shield zone
function Auxiliary.ShieldZoneFilter(f)
	return	function(target,...)
				return target:IsShield() and (not f or f(target,...))
			end
end
--filter to check if a card was sent to the graveyard from the mana zone
--Note: Remove this if YGOPro can flip a face-down banished card face-up
function Auxiliary.PreviousLocationMZoneFilter(c)
	return c:IsPreviousLocation(LOCATION_MZONE)
		or (c:IsPreviousLocation(LOCATION_HAND) and c:IsReason(REASON_TEMPORARY))
end
--flag effect for spell casting
function Auxiliary.chainreg(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(1)==0 then
		e:GetHandler():RegisterFlagEffect(1,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
	end
end
--filter for EFFECT_CANNOT_BE_EFFECT_TARGET + opponent
function Auxiliary.tgoval(e,re,rp)
	return rp==1-e:GetHandlerPlayer()
end
--
function loadutility(file)
	local f=loadfile("expansions/script/"..file)
	if f==nil then
		dofile("script/"..file)
	else
		f()
	end
end
loadutility("bit.lua")
loadutility("card.lua")
loadutility("duel.lua")
loadutility("group.lua")
loadutility("lua.lua")
loadutility("rule.lua")
loadutility("table.lua")
--[[
	References
	1. Name Category
	https://duelmasters.fandom.com/wiki/Name_Category
	2. Cost Reduction and Cost Increase abilities don't increase or decrease the cost written on the card
	https://duelmasters.fandom.com/wiki/Mana_Cost#Rules
	3. Prevent multiple "shield trigger" abilities from chaining
	* Voltanis the Adjudicator
	https://github.com/Fluorohydride/ygopro-scripts/blob/967a2fe/c20951752.lua#L12
	4. Auxiliary.mana_cost_list
	https://duelmasters.fandom.com/wiki/Category:Cards_by_Mana_Cost
	5. Auxiliary.AddSingleTriggerEffect and Auxiliary.AddTriggerEffect Trigger conditions
	https://duelmasters.fandom.com/wiki/List_of_Trigger_Conditions
]]
