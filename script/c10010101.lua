--Soderlight, the Cold Blade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--silent skill (destroy)
	aux.EnableSilentSkill(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--silent skill (destroy)
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_DESTROY)
scard.op1=aux.TargetCardsOperation(Duel.Destroy,REASON_EFFECT)
