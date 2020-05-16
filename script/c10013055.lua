--勇猛妖魔アニマトレイン
--Animatrain, the Daring Beast
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_HEDRIAN,RACE_HORNED_BEAST)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot attack
	aux.EnableCannotAttack(c,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--cannot attack
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetShieldCount(tp)>Duel.GetShieldCount(1-tp)
end
