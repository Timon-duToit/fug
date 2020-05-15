extends Node

class_name SceneChanger

signal scene_changed()

func change_scene(path : String, delay : float = 0) -> void:
	yield(get_tree().create_timer(delay), "timeout")
	get_tree().change_scene(path)

func change_to_main_menu(delay : float = 0) -> void:
	change_scene("res://UI/MainMenu.tscn", delay)
