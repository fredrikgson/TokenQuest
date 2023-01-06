extends Area2D

var card = preload("res://Prefab/Card.tscn")

onready var draw_audio_stream = $AudioStreamPlayer2D


## DECK
var deck = []
var deck_loaded = false
const COMMON_CARDS:int = 20
const RARE_CARDS:int = 12
const EPIC_CARDS:int = 7
const LEGENDARY_CARDS:int = 1

func _ready():
	
	## construct the deck
	## first, get all cards
	var all_cards = get_all_cards()
	
	
	## debug
#	print("Commons: " + str(filter_commons(all_cards).size()))
#	print("Rares: " + str(filter_rares(all_cards).size()))
#	print("Epics: " + str(filter_epics(all_cards).size()))
#	print("Legendaries: " + str(filter_legendaries(all_cards).size()))
#	print("Superlegendaries: " + str(filter_superlegendaries(all_cards).size()))
#
#	for i in filter_superlegendaries(all_cards):
#		print(i.card_name)
	
	
	## next, populate deck with cards of different rarities
	## COMMONS
	var commons = filter_commons(all_cards)
	for i in range(0,COMMON_CARDS):
		commons.shuffle()
		deck.append(commons.front())
	
	## RARES
	var rares = filter_rares(all_cards)
	for i in range(0,RARE_CARDS):
		rares.shuffle()
		deck.append(rares.front())
	
	## EPICS
	var epics = filter_epics(all_cards)
	for i in range(0,EPIC_CARDS):
		epics.shuffle()
		deck.append(epics.front())
	
	## LEGENDARIES
	var legendaries = filter_legendaries(all_cards)
	for i in range(0,LEGENDARY_CARDS):
		legendaries.shuffle()
		deck.append(legendaries.front())
	
	
	## include superlegendary?
	## we cannot have both superlegendary and horsemen
	if (randi()%4) < 1:
		var superlegendaries = filter_superlegendaries(all_cards)
		superlegendaries.shuffle()
		deck.append(superlegendaries.front())
	else:
		## horseman game?
		if (randi()%2) < 1:
			deck.append(load("res://Cards/HorsemanOfDeath.tres"))
			deck.append(load("res://Cards/HorsemanOfPestilence.tres"))
			deck.append(load("res://Cards/HorsemanOfFamine.tres"))
			deck.append(load("res://Cards/HorsemanOfWar.tres"))
	
	
	## next, shuffle deck and place dusk and dawn at front and back respectively
	deck.shuffle()
	deck.push_front(load("res://Cards/Dawn.tres"))
	deck.push_back(load("res://Cards/Dusk.tres"))
	
	## DEBUG
	#deck.push_front(load("res://Cards/HorsemanOfFamine.tres"))
	
	## finally
	deck_loaded = true


func _on_Deck_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and deck_loaded and deck.size() > 0:
		if Mstr.state == Mstr.States.IDLE:
			
			## if last card, hide card below
			if deck.size() <= 1:
				$RestOfDeck.visible = false
			
			Mstr.state = Mstr.States.LOCKED
			$AnimationPlayer.play("Draw")


## called by Draw animation
func spawn_card():
	var new_card = card.instance()
	
	## assign card properties here
	new_card.init_from_resource(deck.pop_front())
	
	get_node("../CardHolder").add_child(new_card)


func play_card_draw_SFX():
	draw_audio_stream.play()


## called by card before leaving tree
## delays state reset by 0.2 to prevent accidental double tap
func _on_ChangeStateToIdle_timeout():
	Mstr.state = Mstr.States.IDLE





func get_all_cards(): #returns an array of all possible cards in the game
	var all_cards = []
	var dir = Directory.new()
	if dir.open("res://Cards/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				all_cards.append(load("res://Cards/" + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Error when trying to open the path")
	return all_cards


func filter_commons(all_cards):
	var commons = []
	for i in all_cards:
		if i.card_rarity == i.CardRarities.COMMON:
			commons.append(i)
	return commons
func filter_rares(all_cards):
	var rares = []
	for i in all_cards:
		if i.card_rarity == i.CardRarities.RARE:
			rares.append(i)
	return rares
func filter_epics(all_cards):
	var epics = []
	for i in all_cards:
		if i.card_rarity == i.CardRarities.EPIC:
			epics.append(i)
	return epics
func filter_legendaries(all_cards):
	var legendaries = []
	for i in all_cards:
		if i.card_rarity == i.CardRarities.LEGENDARY:
			legendaries.append(i)
	return legendaries
func filter_superlegendaries(all_cards):
	var superlegendaries = []
	for i in all_cards:
		if i.card_rarity == i.CardRarities.SUPERLEGENDARY:
			superlegendaries.append(i)
	return superlegendaries
