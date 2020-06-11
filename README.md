# YGOPro DM

<p align="center">
	<img src="https://user-images.githubusercontent.com/18324297/82112862-5dcbbd80-9751-11ea-9e28-f37fbd9795a9.png">
</p>

## How to play
1. Start YGOPro.
2. Click on `Deck Management` to build your deck. Remember to add 1 _Duel Masters Rules_!
If you do not build your deck according to the following rules, you will lose the game and have to rebuild your deck:<br>
● Your deck must be exactly 40 cards.<br>
3. At the start of the game, take 5 cards from the top of your deck without [looking](https://duelmasters.fandom.com/wiki/Look) at them and put them in a row in front of you face down. These face down cards are your [shields](https://duelmasters.wikia.com/wiki/Shield). (You can only have a maximum of 5 shields in YGOPro.) Then [draw](https://duelmasters.fandom.com/wiki/Draw) 5 cards. There is no limit to the number of cards you can have in your hand.
4. During your [Start of Turn Step](https://duelmasters.fandom.com/wiki/Start_of_Turn_Step), [untap](https://duelmasters.fandom.com/wiki/Tap_(Untap)) all your [tapped](https://duelmasters.fandom.com/wiki/Tap_(Untap)) creatures in the [battle zone](https://duelmasters.fandom.com/wiki/Battle_Zone) and tapped cards in your [mana zone](https://duelmasters.fandom.com/wiki/Mana_Zone).
5. During your [Draw Step](https://duelmasters.fandom.com/wiki/Draw_Step), draw 1 card. The person who plays first skips drawing a card on their first turn.
6. During your [Charge Step](https://duelmasters.fandom.com/wiki/Charge_Step), you can put a card from your hand into your mana zone. There is no limit to the number of cards you can have in your mana zone.
7. During your [Main Step](https://duelmasters.fandom.com/wiki/Main_Step), you can [play](https://duelmasters.fandom.com/wiki/Play) as many [creatures](https://duelmasters.fandom.com/wiki/Creature), [spells](https://duelmasters.fandom.com/wiki/Spell), [cross gears](https://duelmasters.fandom.com/wiki/Cross_Gear), and [castles](https://duelmasters.fandom.com/wiki/Castle) as your mana zone can afford. You can play any card in any order. (You can only have a maximum of 6 creatures in YGOPro.)
8. During your [Attack Step](https://duelmasters.fandom.com/wiki/Attack_Step), you can [attack](https://duelmasters.fandom.com/wiki/Attack) with your creatures in the battle zone by tapping them and declaring what you want to attack. You cannot attack with creatures you just put into the battle zone this turn because they have [summoning sickness](https://duelmasters.fandom.com/wiki/Summoning_Sickness). There is no limit to the number of times a creature can attack each turn as long as it is untapped and you can tap it.
9. During your [End Step](https://duelmasters.fandom.com/wiki/End_Step), [resolve](https://duelmasters.fandom.com/wiki/Resolution) any [abilities](https://duelmasters.fandom.com/wiki/Ability) that [trigger](https://duelmasters.fandom.com/wiki/Trigger) "at the end of your turn". Then your turn ends.

**Important:**
1. This YGOPro game is only compatible with the Microsoft Windows operating system.
2. Online play is not supported.
3. At least 1 player must have _Duel Masters Rules_ in their deck, otherwise the mod will not function properly.
4. Enable `Do not check Deck` when creating a game to avoid an error due to a player having 4 copies of a card with the same [name](https://duelmasters.fandom.com/wiki/Card_Name) in their deck.
5. YGOPro does not allow you to look at a tapped card in your opponent's mana zone that was put there from a [Private Zone](https://duelmasters.fandom.com/wiki/Private_Zone). You will be able to look at it when it untaps, or is put into a [Public Zone](https://duelmasters.fandom.com/wiki/Public_Zone).

## How to win
1. Attack your opponent with a creature that is not [blocked](https://duelmasters.fandom.com/wiki/Block) (or [attack bended](https://duelmasters.fandom.com/wiki/Attack_Bend)) or removed when they have no shields left.
2. When your opponent has no cards left in their deck or they would draw their last card.
3. [Some cards](https://duelmasters.wikia.com/wiki/Template:Alternate_Win_Condition) will enable you to win the game via their [effects](https://duelmasters.wikia.com/wiki/Effect).

## Extra information
<details>
<summary>OT (OCG/TCG)</summary>

- `0x1	OCG` = [OCG](https://duelmasters.fandom.com/wiki/OCG) only card
- `0x2	TCG` = [TCG](https://duelmasters.fandom.com/wiki/TCG) only card
- `0x3	OCG+TCG` = OCG + TCG card
- `0x4	Anime/Custom` = [Game Original](https://duelmasters.fandom.com/wiki/Game_Original_Card)/Unofficial card
</details>
<details>
<summary>Card Type</summary>

- `0x21	Monster+Effect` = Creature
- `0x1021	Monster+Effect+Tuner` = Creature that has [no abilities](https://duelmasters.wikia.com/wiki/Vanilla)
- `0x2000021	Monster+Effect+Special Summon` = [Evolution Creature](https://duelmasters.fandom.com/wiki/Evolution_Creature)
	- `Attribute` = [Civilization](https://duelmasters.fandom.com/wiki/Civilization)
	- `Level` = [Mana Cost](https://duelmasters.fandom.com/wiki/Mana_Cost)
	- `ATK` = `DEF` = [Power](https://duelmasters.fandom.com/wiki/Power)
- `0x3	Monster+Spell` = Spell
	- `Attribute` = Civilization
	- `Level` = Mana Cost
- `0x800	Gemini` = [Multi-civilization](https://duelmasters.fandom.com/wiki/Multicolored) card
</details>
<details>
<summary>Attribute</summary>

- `0x1	EARTH` = [Light Civilization](https://duelmasters.fandom.com/wiki/Light_Civilization)
- `0x2	WATER` = [Water Civilization](https://duelmasters.fandom.com/wiki/Water_Civilization)
- `0x4	FIRE` = [Darkness Civilization](https://duelmasters.fandom.com/wiki/Darkness_Civilization)
- `0x8	WIND` = [Fire Civilization](https://duelmasters.fandom.com/wiki/Fire_Civilization)
- `0x10	LIGHT` = [Nature Civilization](https://duelmasters.fandom.com/wiki/Nature_Civilization)
</details>
<details>
<summary>Setcode</summary>

- Refer to `!setname` in `strings.conf`.
</details>
<details>
<summary>Location</summary>

- `0x4	Monster Zone` = Battle Zone
- `0x8	Spell & Trap Zone` = Shield Zone
- `0x10	Graveyard` = Mana Zone (untapped cards)
- `0x20	Banished` = Mana Zone (tapped cards) (text color = blue)
- `0x20	Banished` = [Graveyard](https://duelmasters.fandom.com/wiki/Graveyard) (text color = black)
- `0x40	Extra Deck` = Hyperspatial Zone
- `0x80	Xyz Material` = [Evolution Source](https://duelmasters.fandom.com/wiki/Evolution_Source)
</details>
<details>
<summary>Phase</summary>

1. `EVENT_PREDRAW` = Start of Turn Step (Untap Step) = Untap all your tapped cards.
2. `PHASE_DRAW` = Draw Step = Draw 1 card from your deck.
3. `PHASE_STANDBY` = Charge Step = You may put a card from your hand into your mana zone.
4. `PHASE_MAIN1` = Main Step = You may use cards, such as summoning creatures, casting spells, generating and crossing cross gear or fortifying castles by paying the appropriate costs.
5. `PHASE_BATTLE` = Attack Step = You may attack with creatures or use [Tap Abilities](https://duelmasters.fandom.com/wiki/Tap_Ability).
6. `PHASE_MAIN2` = **N/A**
7. `PHASE_END` = End Step = Any abilities that trigger at "the end of the turn" resolve now.
</details>
<details>
<summary>Category</summary>

- `0x1	Destroy Spell/Trap` = Decrease the number of cards in the opponent's shield zone; "Breaker"
- `0x2	Destroy Monster` = Destroy a creature
- `0x4	Banish Card` = Put a card into the graveyard; discard a card from a player's hand
- `0x8	Send to Graveyard` = Put a card into the mana zone
- `0x10	Return to Hand` = Return a card from the battle zone, shield zone, mana zone or graveyard to a player's hand
- `0x20	Return to Deck` = Put a card into a player's deck
- `0x40	Destroy Hand` = Decrease the opponent's hand size
- `0x80	Destroy Deck` = Decrease the opponent's deck size
- `0x100	Increase Draw` = Draw a card from the deck
- `0x200	Search Deck` = Look at a player's deck
- `0x400	GY to Hand/Field` = ～Reserved～
- `0x800	Change Battle Position` = Untap or tap a card
- `0x1000	Get Control` = Increase or decrease the cost required for playing a card
- `0x2000	Increase/Decrease ATK/DEF` = Increase or decrease a creature's power
- `0x4000	Piercing` = No summoning sickness
- `0x8000	Attack Multiple Times` = Can attack untapped creatures
- `0x10000	Limit Attack` = Prevent a creature from attacking; change a creature's attack target
- `0x20000	Direct Attack` = Attacks each turn if able; force a creature to battle another creature
- `0x40000	Special Summon` = Creature with "Shield trigger"; put a card into the battle zone
- `0x80000	Token` = ～Reserved～
- `0x100000	Type-related` = Lists "race" or a particular race in the card's text
- `0x200000	Attribute-related` = Lists "civilization" or a particular civilization in the card's text
- `0x400000	Reduce LP` = Decrease the number of cards in the opponent's mana zone
- `0x800000	Increase LP` = Increase the number of cards in the shield zone
- `0x1000000	Cannot Be Destroyed` = Prevent a card from being destroyed
- `0x2000000	Cannot Be Targeted` = Prevent a creature from being blocked or chosen with an ability
- `0x4000000	Counter` = Prevent the opponent from casting spells
- `0x8000000	Gamble` = ～Reserved～
- `0x10000000	Fusion` = ～Reserved～
- `0x20000000	Synchro` = ～Reserved～
- `0x40000000	Xyz` = Evolution creature; lists "evolution" in the card's text; [evolution source](https://duelmasters.fandom.com/wiki/Evolution_Source)-related
- `0x80000000	Negate Effect` = ～Reserved～
- [Category list](https://duelmasters.fandom.com/wiki/Category:Advanced_Gameplay)
</details>
<details>
<summary>Card Search</summary>

You can search for the following specific card information in YGOPro:
- Card Ability: Use the `No Ability` tab for creatures that have no abilities
- Card Type: Use the `Type` tab
- Civilization: Use the `Civ` tab
- Evolution Creature: Use the `Evolution` tab
- Mana Cost: Use the `Cost` tab
- Multicolored: Use the `Multicolor` tab
- Power: Use the `Power` tab
- Race: **N/A**
- Region-exclusive cards: Use the `Limit` tab
- You can also search for cards whose abilities have been modified for YGOPro by typing `YGOPro`.
</details>
