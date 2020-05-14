extends Node

class_name BasicMobMC

export var acceleration : float = 20
export var rotate_acceleration : float = 20
export var look_at_move : bool = true

var speed_target := Vector2.ZERO
var look_at_target := Vector2.RIGHT
var friction : float = 0
# if the movement controller tries to change _speed to speed_target
var active_move := true

var _speed := Vector2.ZERO

onready var _mob : Mob = owner

func _physics_process(delta: float) -> void:
	if look_at_move && speed_target.length() > 0:
		look_at_target = speed_target
	_rotate(delta)
	_move(delta)

func _rotate(delta : float) -> void:
	var delta_angle = look_at_target.angle() - _mob.rotation
	if abs(delta_angle) > PI:
		delta_angle = delta_angle - sign(delta_angle) * 2 * PI
	# HACK: don't use delta here. use proper formula or curve
	_mob.rotation += lerp(0, delta_angle, rotate_acceleration * delta)

func _move(delta : float) -> void:
	if active_move:
		_speed = lerp(_speed, speed_target, delta * acceleration)
	if friction:
		_decrease_velocity(delta * friction)
	_mob.move_and_slide(_speed)

func _decrease_velocity(amount : float):
	# returns the new velocity
	if amount > _speed.length():
		_speed = Vector2.ZERO
		return 0
	_speed -= _speed.normalized() * amount
	return _speed.length()


func get_speed() -> float:
	return _speed.length()
