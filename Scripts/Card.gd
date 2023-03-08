extends Area2D

## stores the resource
var resource:Card

## used for the double tap shenanigans
## to prevent accidental tapping-removing
var block_remove = true

## sounds for extended description button
onready var stream_open = $ExtendedDesc/stream_open
onready var stream_close = $ExtendedDesc/stream_close

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
	"the drunkest player",
	"the least drunk player",
	"the player with the most Tokens",
	"the player you know the least",
	"the player you know the best",
	"the tallest player",
	"the shortest player"
]


## remove from screen if user taps on the card
func _on_Card_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Mstr.state == Mstr.States.DISPLAYING_CARD:
			if !block_remove:
				get_tree().get_root().get_node("Game/Deck/ChangeStateToIdle").start()
				queue_free()
			else:
				block_remove = false
				$Outline.modulate.a = 0.8
				$Timer.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Display":
		## animation for showing card is completed, change state in Mstr
		Mstr.state = Mstr.States.DISPLAYING_CARD
		
		## also, if card has extended desc, show the button
		if resource and resource.extended_description != "" and resource.extended_description != null:
			$ExtendedDesc.visible = true


## renders a card from a Card resource onto the Card shown
## this is called from Deck.gd when a new card is drawn
func init_from_resource(res:Card):
	resource = res
	$Outline/BorderColor.self_modulate = res.get_border_color()
	$Outline/CardArt.texture = res.card_art
	$Outline/CardName.text = res.card_name
	$Outline/CardDescription.text = res.card_text
	$Outline/RarityRing/RarityFill.self_modulate = res.get_rarity_color()
	
	## if Duel, append one of the duel_opponent strings to the card text
	if res.card_type == res.CardTypes.DUEL:
		duel_opponents.shuffle()
		var opp = duel_opponents.front()
		$Outline/CardDescription.text += " Target " + str(opp) + "."
	
	## set up extended description
	## this happens even if there is no such
	## however, the button to display extended desc won't show up
	$Outline/ExtendedDescription/Outline/BorderColor.self_modulate = res.get_border_color()
	$Outline/ExtendedDescription/Outline/CardName.text = res.card_name
	$Outline/ExtendedDescription/Outline/Desc.text = res.extended_description


## tap timer
func _on_Timer_timeout():
	block_remove = true
	$Outline.modulate.a = 1


## when user taps on extended description button
func _on_ExtendedDesc_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		## toggle if extended desc is visible or not
		if $Outline/ExtendedDescription.visible:
			$Outline/ExtendedDescription.visible = false
			$ExtendedDesc/Sprite.frame = 0
			stream_close.play()
		else:
			$Outline/ExtendedDescription.visible = true
			$ExtendedDesc/Sprite.frame = 1
			stream_open.play()
