extends Node

# SINGLETON

# The level mananger will register himself here
var level_manager : LevelManager
var player : Player setget set_player, get_player

var _last_speed : float = 1

#func _ready():
#	Engine.time_scale = 0.1

func set_player(value : Player) -> void:
	print("DO NOT SET PLAYER VIA THIS!")
	
func get_player() -> Player:
	return level_manager.player

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_F:
				OS.window_fullscreen = !OS.window_fullscreen
			elif event.scancode == KEY_R:
				if Engine.time_scale == 1:
					Engine.time_scale = 0.1
				else:
					Engine.time_scale = 1
			elif event.scancode == KEY_P:
				if Engine.time_scale == 0:
					Engine.time_scale = _last_speed
				else:
					_last_speed = Engine.time_scale
					Engine.time_scale = 0
