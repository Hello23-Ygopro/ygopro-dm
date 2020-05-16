--宣凶師ルベルス
--Rubels, the Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_GLADIATOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm broken shield
	aux.EnablePlayerEffectCustom(c,EFFECT_CONFIRM_BROKEN_SHIELD,0,1)
end
