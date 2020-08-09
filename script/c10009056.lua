--Petrova, Channeler of Suns
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_DEL_SOL)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--cannot be targeted
	aux.EnableCannotBeTargeted(c)
end
--get ability
function scard.abfilter(c,race)
	return c:IsFaceup() and c:DMIsRace(race)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local t1=aux.race_desc_list
	local t2=aux.race_value_list
	local item1=table.find(t1,OPTION_MECHA_DEL_SOL)
	local item2=table.find(t2,RACE_MECHA_DEL_SOL)
	table.remove(t1,item1)
	table.remove(t2,item2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCERACE)
	local race=Duel.DMAnnounceRace(tp)
	table.insert(t1,1,OPTION_MECHA_DEL_SOL)
	table.insert(t2,1,RACE_MECHA_DEL_SOL)
	local c=e:GetHandler()
	--power up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(4000)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_BZONE,LOCATION_BZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.DMIsRace,race))
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,tp)
	--reset power up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e2)
	e3:SetCondition(scard.con1)
	e3:SetOperation(scard.op2)
	Duel.RegisterEffect(e3,tp)
end
--reset power up
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_BZONE) or not c:IsFaceup()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local e1=e:GetLabelObject()
	e1:Reset()
	e:Reset()
end
--[[
	Rulings
	* As soon as Petrova, Channeler of Suns leaves the battle zone, the creatures of the chosen race lose the increase of
	power.
	https://duelmasters.fandom.com/wiki/Petrova,_Channeler_of_Suns/Rulings
]]
