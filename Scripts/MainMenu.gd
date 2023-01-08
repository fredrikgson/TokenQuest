extends Node2D

var game_scene = preload("res://Scenes/Game.tscn")

## handle tap on PlayButton
func _on_PlayButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene("res://Scenes/Game.tscn")
