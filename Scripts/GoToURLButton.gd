extends Area2D

export(String) var url = "https://github.com/fredrikgson/TokenQuest"

func _on_GoToGitHub_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		OS.shell_open(url)
