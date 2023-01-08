extends Node2D

export(String) var target_scene_path = "res://Scenes/MainMenu.tscn"
export(bool) var require_double_tap = false

# when true, button will have no effect
var block_redirect = false
onready var timer = $Timer

func _ready():
	
	# if require_double_tap is checked
	# the back button will need two taps in order to redirect
	# this is a measure to prevent accidental tapping when in game
	if require_double_tap:
		
		block_redirect = true
		# make arrow transparent by default to indicate that it won't redirect
		$Area2D/Sprite.self_modulate.a = 0.4

# handle tap on back button
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		if !block_redirect:
			get_tree().change_scene(target_scene_path)
		else:
			# make button active for a short time
			block_redirect = false
			$Area2D/Sprite.self_modulate.a = 1
			timer.start()


func _on_Timer_timeout():
	block_redirect = true
	$Area2D/Sprite.self_modulate.a = 0.4
