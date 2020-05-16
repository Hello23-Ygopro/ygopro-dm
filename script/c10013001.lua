--悪魔聖霊バルホルス
--Balforce, the Demonic Holy Spirit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND,RACE_DEMON_COMMAND)
	aux.AddRaceCategory(c,RACECAT_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--get ability (must attack)
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK,nil,0,LOCATION_BZONE)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,nil,aux.SelfUntapOperation(),nil,aux.SelfBlockCondition)
end
