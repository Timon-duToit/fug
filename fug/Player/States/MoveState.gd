extends PlayerState

class_name MoveState

export var speed : float = 150
# export var test_curve : Curve
export var acceleration : float = 20

var _movement := Vector2()
var _movement_target := Vector2()

func enter(controller_: StateMachine) -> void:
	.enter(controller_)
	_animator.play("Idle")

func process(delta : float) -> void:
	.process(delta)
	_handle_inputs()

func physics_process(delta : float) -> void:
	# this is jank. the correlation between delta and acceleration is not linear!
	_movement = lerp(_movement, _movement_target, acceleration * delta)
	owner.move_and_slide(_movement)
	_aim_body_to_camera(delta)

func _handle_inputs() -> void:
	_movement_target = Vector2()
	if Input.is_action_pressed("up"):
		_movement_target += Vector2.UP
	if Input.is_action_pressed("down"):
		_movement_target += Vector2.DOWN
	if Input.is_action_pressed("right"):
		_movement_target += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		_movement_target += Vector2.LEFT
	_movement_target = _movement_target.normalized() * speed

func _aim_body_to_camera(delta : float) -> void:
	var delta_angle = owner.body.get_angle_to(owner.body.get_global_mouse_position())
	# HACK: don't use lerp / multiply by delta here or use a proper formula
	owner.body.rotation += lerp(0, delta_angle, 20 * delta)
