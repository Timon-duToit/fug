extends KinematicBody2D

class_name Mob

signal death
signal shoved

onready var _state_machine : StateMachine = $StateMachine
onready var animator : AnimatedSprite = $AnimatedSprite
onready var _collider : CollisionShape2D = $CollisionShape2D
onready var shove_area : Area2D = $ShoveArea
onready var shove_collider : CollisionShape2D = $ShoveArea/Collider
onready var audio := $Audio

func _ready() -> void:
	_state_machine.connect("change_state", self, "_on_StateMachine_change_state")

func _on_StateMachine_change_state(last_state_name : String, new_state_name : String):
	if new_state_name == "Dead":
		emit_signal("death")

func hit() -> void:
	_die()
	
func _die() -> void:
	_state_machine.change_to("Dead")

func get_shoved(direction : Vector2, shove_strength : float) -> void:
	_state_machine.change_to("Shoved")
	_state_machine.state.init_shove(direction, shove_strength)
	emit_signal("shoved")

func play_animation(animation : String) -> void:
	animator.play(animation)
	
func set_collider_disabled(state : bool) -> void:
	_collider.set_deferred("disabled", state)

func get_grappled() -> void:
	_state_machine.change_to("Grappled")

func release() -> void:
	pass

func is_dead() -> bool:
	return _state_machine.state.name == "Dead"
