extends Node

# SINGLETON

# The level mananger will register himself here
var level_manager : LevelManager
var player : Player setget set_player, get_player

#func _ready():
#	Engine.time_scale = 0.1

func set_player(value : Player) -> void:
	print("DO NOT SET PLAYER VIA THIS!")
	
func get_player() -> Player:
	return level_manager.player
