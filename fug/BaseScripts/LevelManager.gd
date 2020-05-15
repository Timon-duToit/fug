extends Node

class_name LevelManager

onready var player : Player = $Player
onready var debug_node : Node2D = $DebugNode

func _ready() -> void:
	GameManager.level_manager = self
	player.connect("death", self, "_on_Player_death")

func _on_Player_death() -> void:
	GameManager.scene_changer.change_to_main_menu(2)
