extends CanvasLayer

signal scene_changed()

onready var black = $Control/Black

func change_scene(path, delay = 0.5):
	
	# wait the delay (dont change scenes immediately)
	yield(get_tree().create_timer(delay), "timeout")
	
	# Change the scene for the given path
	get_tree().change_scene(path)
