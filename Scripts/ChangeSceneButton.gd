extends Area2D

export(String) var button_text = "Button"
export(String) var target_scene = "res://Scenes/MainMenu.tscn"

func _ready():
	$Label.text = button_text

func _on_PlayButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene(target_scene)
