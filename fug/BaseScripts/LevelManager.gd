extends Node

class_name LevelManager

onready var player : Player = $Player
onready var debug_node : Node2D = $DebugNode

func _ready() -> void:
	GameManager.level_manager = self
