extends Node

class_name LevelManager

onready var player : Player = $Player

func _ready() -> void:
	GameManager.level_manager = self
	player.connect("death", self, "_on_Player_death")

func _on_Player_death() -> void:
	SceneChanger.change_scene("res://Scenes/HUD.tscn", 2)
