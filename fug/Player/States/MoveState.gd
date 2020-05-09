extends State

class_name MoveState

export var speed : float = 150
# export var test_curve : Curve
export var acceleration : float = 20

var _movement := Vector2()
var _movement_target := Vector2()

# Animation should be its own thing
onready var _animator = owner.get_node("Body/Animator")

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
