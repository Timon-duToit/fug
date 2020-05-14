extends KinematicBody2D

class_name Actor

signal death

export var max_hp : int = 100

var _hp : int = max_hp

# This will get restored by _set_normal_physics()
onready var _default_collision_layer := collision_layer
onready var _default_collision_mask := collision_mask

func hit(damage : int) -> void:
	_hp = max(0, _hp - damage)
	if _hp == 0:
		die()

func burn(damage : int) -> void:
	pass

func die() -> void:
	emit_signal("death")
	collision_layer = 0
	collision_mask = 0

func get_shoved(impulse : Vector2) -> void:
	_set_grappled_physics()
	die()

func be_shield() -> void:
	pass

func be_weapon() -> void:
	pass

func be_grappled() -> bool:
	# returns true if the grapple has succeeded
	_set_grappled_physics()
	return true

func be_ungrappled() -> void:
	_set_normal_physics()

func _set_grappled_physics() -> void:
	# don't collider with player
	set_collision_mask_bit(1, false)
	# move to grappled layer
	collision_layer = 8

func _set_normal_physics() -> void:
	collision_layer = _default_collision_layer
	collision_mask = _default_collision_mask
