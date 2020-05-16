## Zones
- [ ] **You can't have more than 5 cards in the battle zone**
- You can't summon a non-evolution creature, while you have 5 creatures.
- [ ] **You can't have more than 5 cards in the shield zone**
- [ ] **You're allowed to look at your shields at any time**
- If you're required to select your shield, the game will do it randomly for you.
- [ ] **There are no [zones](https://yugioh.fandom.com/wiki/Zone) for the graveyard/discard pile**
- [Face-up](https://yugioh.fandom.com/wiki/Face-up) [banished](https://yugioh.fandom.com/wiki/Banish) cards are in the graveyard.
- [Face-down](https://yugioh.fandom.com/wiki/Face-down) banished cards are tapped in the mana zone, and they have blue text.
- [ ] **You can't put a tapped card in your mana zone into the graveyard**
- If you select a tapped card in your mana zone, the game will first put it into your hand before banishing it face-up.
## Card Attacking and Battle
- [ ] **You can't tap your creatures to attack with them**
- When your creature attacks, it taps at the end of the [damage step](https://yugioh.fandom.com/wiki/Damage_Step).
## Card Effects
- [ ] **The [Level](https://yugioh.fandom.com/wiki/Level) (Mana Cost) on a card should not be changed**
> While Cost Reduction and Cost Increase abilities alter the cost you pay, they don't actually increase or decrease the cost on the written card.
- Cost Reduction abilities should not decrease a card's Level. [Source](https://duelmasters.fandom.com/wiki/Mana_Cost#Rules)
- A card's Level will still change to show each player how much it costs, while the game uses its original Level for the appropriate ability.
	- [ ] _They can't cost less than 2+_ isn't implemented. (e.g. _[Cocco Lupia](https://duelmasters.fandom.com/wiki/Cocco_Lupia)_ DM-06 77/110)
	- [ ] Applying the higher value of multiple _They can't cost less than X_ isn't implemented. [Source](https://duelmasters.fandom.com/wiki/Cost_Reduction#Rules)
- [ ] **_Your opponent can't tap this creature_ isn't fully implemented**
(e.g. _[Ulex, the Dauntless](https://duelmasters.fandom.com/wiki/Ulex,_the_Dauntless)_ DM-10 104/110)
	- [ ] A creature with this ability prevents all players from tapping it.
- [ ] **_When this creature would leave the battle zone_ isn't fully implemented**
(e.g. _[Soul Phoenix, Avatar of Unity](https://duelmasters.fandom.com/wiki/Soul_Phoenix,_Avatar_of_Unity)_ DM-12 5/55)
	- [ ] A creature with this ability is still treated as leaving the field.
	- [ ] This ability won't apply when a creature is added to your shields.
	- [x] This ability won't apply when a creature is put into your deck.
- [ ] **_When this creature leaves the battle zone_ isn't fully implemented**
(e.g. _[Wise Starnoid, Avatar of Hope](https://duelmasters.fandom.com/wiki/Wise_Starnoid,_Avatar_of_Hope)_ DM-12 S2/S5)
	- [ ] This ability won't trigger when a creature is added to your shields.
- [ ] **_Whenever [a creature] is destroyed_ isn't fully implemented**
(e.g. _[Mongrel Man](https://duelmasters.fandom.com/wiki/Mongrel_Man)_ DM-04 33/55)
	- [ ] This ability won't trigger if the creature with this ability and another appropriate creature are destroyed at the same time.
	- [ ] This ability won't trigger multiple times when multiple creatures are destroyed. [Source](https://duelmasters.fandom.com/wiki/Trigger_Ability#Rulings)
- [ ] **_Sympathy: RACE1 and RACE2_ isn't fully implemented**
- If a creature in the battle zone has both of the specified races, only one of those races can count towards the "Sympathy" ability. [Source](https://duelmasters.fandom.com/wiki/Dolgeza,_Veteran_of_Hard_Battle/Rulings)
- [ ] **_When this creature loses a battle against an X creature, this creature isn't destroyed_ isn't fully implemented**
	- [ ] If your creature can't be destroyed in a battle against a specified creature, then it won't be destroyed by battle against _any_ creature. (e.g. _[Amnis, Holy Elemental](https://duelmasters.fandom.com/wiki/Amnis,_Holy_Elemental)_ (L3/6 Y1) isn't destroyed when it loses a battle against a non-darkness creature.)
