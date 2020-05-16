--妖魔賢者メルカプ
--Melcap, the Mutant Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR,RACE_HEDRIAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,nil,nil,scard.op1,nil,scard.con1)
end
--tap
scard.con1=aux.AND(aux.UnblockedCondition,aux.AttackPlayerCondition)
scard.op1=aux.TapOperation(nil,Card.IsFaceup,0,LOCATION_BZONE)
