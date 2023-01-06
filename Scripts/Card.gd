extends Area2D


### DEBUG
#var cards = [
#	load("res://Cards/AndJusticeForAll.tres"),
#	load("res://Cards/BubbleMaster.tres"),
#	load("res://Cards/CropHarvesting.tres"),
#	load("res://Cards/EvilTravellingSalesman.tres"),
#	load("res://Cards/HiredThief.tres"),
#	load("res://Cards/KindStranger.tres"),
#	load("res://Cards/LastManStanding.tres"),
#	load("res://Cards/MarketDay.tres"),
#	load("res://Cards/Plague.tres"),
#	load("res://Cards/Prohibition.tres"),
#	load("res://Cards/PubBrawl.tres"),
#	load("res://Cards/PurchaseAPint.tres"),
#	load("res://Cards/RockPaperScissors.tres"),
#	load("res://Cards/Seance.tres"),
#	load("res://Cards/TheExiled.tres"),
#	load("res://Cards/ThisRoundsOnMe.tres"),
#	load("res://Cards/TravellingSalesman.tres"),
#	load("res://Cards/TreasureChest.tres"),
#	load("res://Cards/WitchsTrial.tres"),
#	load("res://Cards/Jousting.tres"),
#]


## duel opponents
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


#func _ready():
#	cards.shuffle()
#	var card_res = cards.front()
#	init_from_resource(card_res)

func _on_Card_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Mstr.state == Mstr.States.DISPLAYING_CARD:
			get_tree().get_root().get_node("Game/Deck/ChangeStateToIdle").start()
			queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Display":
		## animation for showing card is completed, change state in Mstr
		Mstr.state = Mstr.States.DISPLAYING_CARD


func init_from_resource(res:Card):
	$Outline/BorderColor.self_modulate = res.get_border_color()
	$Outline/CardArt.texture = res.card_art
	$Outline/CardName.text = res.card_name
	$Outline/CardDescription.text = res.card_text
	$Outline/RarityRing/RarityFill.self_modulate = res.get_rarity_color()
	
	## if Duel
	if res.card_type == res.CardTypes.DUEL:
		duel_opponents.shuffle()
		var opp = duel_opponents.front()
		$Outline/CardDescription.text += " Duel " + str(opp) + "."
