extends KinematicBody2D

class_name Mob

onready var _state_machine := $StateMachine

func hit() -> void:
	_die()
	
func _die() -> void:
	_state_machine.change_to("Dead")
