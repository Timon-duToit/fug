extends Node

class_name SkillManager

onready var player := owner

func enable_dash() -> void:
	owner.has_dash = true

func enable_grappling_hook() -> void:
	owner.has_grappling_hook = true
