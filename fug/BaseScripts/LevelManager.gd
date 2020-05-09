extends Node

class_name LevelManager

onready var player : Player = $Player

func _ready() -> void:
	GameManager.level_manager = self
