extends KinematicBody2D

class_name Mob

onready var _state_machine := $StateMachine

func hit() -> void:
	_die()
	
func _die() -> void:
	_state_machine.change_to("Dead")

func get_shoved(other_position : Vector2, other_rotation : float, shove_strength : float) -> void:
	_state_machine.change_to("Shoved")
	_state_machine.state.init_shove(other_position, other_rotation, shove_strength)
	# print("%s %s %s" % [other_position, other_rotation, shove_strength])
