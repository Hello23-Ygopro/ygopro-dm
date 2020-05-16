--妖蟲幻風ギュネール
--Spectral Worm Giunair
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_RAINBOW_PHANTOM,RACE_PARASITE_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack player
	aux.EnableCannotAttackPlayer(c)
	--slayer
	aux.EnableSlayer(c)
end
