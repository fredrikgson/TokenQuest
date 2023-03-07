extends Control

var database_item = preload("res://Prefab/CardDatabaseItem.tscn")
onready var vbox = $ScrollContainer/VBoxContainer

func _ready():
	
	## fill database with all resources
	var all_cards = get_all_cards()
	
	for i in all_cards:
		var new_database_item = database_item.instance()
		new_database_item.init_from_resource(i)
		vbox.add_child(new_database_item)



func get_all_cards(): #returns an array of all Card resources in the game
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
