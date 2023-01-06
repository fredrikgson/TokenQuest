extends Area2D

## possible opponents for Duel cards
## one of these strings will be appended to the card text is it is a Duel card
var duel_opponents = [
	"the player across",
	"the player to the left",
	"the player to the right",
	"the player 2 steps to the right",
	"the player 2 steps to the left",
	"the oldest player",
	"the youngest player",
	"the player with the largest feet",
	"the player with the smallest feet",
	"a player of your choice",
	"the player with the most colourful outfit",
	"the drunkest player",
	"the least drunk player",
	"the player with the most Tokens"
]

## remove from screen if user taps on the card
func _on_Card_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Mstr.state == Mstr.States.DISPLAYING_CARD:
			get_tree().get_root().get_node("Game/Deck/ChangeStateToIdle").start()
			queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Display":
		## animation for showing card is completed, change state in Mstr
		Mstr.state = Mstr.States.DISPLAYING_CARD


## renders a card from a Card resource onto the Card shown
## this is called from Deck.gd when a new card is drawn
func init_from_resource(res:Card):
	$Outline/BorderColor.self_modulate = res.get_border_color()
	$Outline/CardArt.texture = res.card_art
	$Outline/CardName.text = res.card_name
	$Outline/CardDescription.text = res.card_text
	$Outline/RarityRing/RarityFill.self_modulate = res.get_rarity_color()
	
	## if Duel, append one of the duel_opponent strings to the card text
	if res.card_type == res.CardTypes.DUEL:
		duel_opponents.shuffle()
		var opp = duel_opponents.front()
		$Outline/CardDescription.text += " Duel " + str(opp) + "."
