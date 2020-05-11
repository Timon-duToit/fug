extends KinematicBody2D

class_name Mob

onready var _state_machine : StateMachine = $StateMachine
onready var animator : AnimatedSprite = $AnimatedSprite
onready var _collider : CollisionShape2D = $CollisionShape2D
onready var shove_area : Area2D = $ShoveArea
onready var shove_collider : CollisionShape2D = $ShoveArea/Collider

func hit() -> void:
	_die()
	
func _die() -> void:
	_state_machine.change_to("Dead")

func get_shoved(other_position : Vector2, other_rotation : float, shove_strength : float) -> void:
	_state_machine.change_to("Shoved")
	_state_machine.state.init_shove(other_position, other_rotation, shove_strength)
	# print("%s %s %s" % [other_position, other_rotation, shove_strength])

func play_animation(animation : String) -> void:
	animator.play(animation)
	
func set_collider_disabled(state : bool) -> void:
	_collider.set_deferred("disabled", state)

func get_grappled() -> void:
	_state_machine.change_to("Grappled")

func release() -> void:
	_state_machine.change_to("Dead")
