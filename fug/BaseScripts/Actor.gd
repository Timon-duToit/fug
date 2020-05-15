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
	collision_mask = Util.LAYER_WALLS

func get_shoved(impulse : Vector2) -> void:
	die()

func be_shield() -> void:
	pass

func be_weapon() -> void:
	pass

func be_grappled() -> bool:
	# returns true if the grapple has succeeded
	return false

func be_ungrappled() -> void:
	_reset_physics()

func _reset_physics() -> void:
	collision_layer = _default_collision_layer
	collision_mask = _default_collision_mask
	
func can_see(actor : Actor) -> bool:
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, actor.global_position, [], Util.LAYER_WALLS)
	return result.empty()

func measure_distance(direction : Vector2, max_range : float = 10000) -> float:
	# NOTE: max range is reltive to direction vector length
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, global_position + direction * max_range, [], Util.LAYER_WALLS)
	if result.empty():
		return INF
	return result["position"].distance_to(global_position)
