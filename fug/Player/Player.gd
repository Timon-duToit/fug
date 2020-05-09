extends KinematicBody2D

export var speed : float = 150
# export var test_curve : Curve
export var acceleration : float = 20

var _movement := Vector2()
var _movement_target := Vector2()

onready var _animator := $Body/Animator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animator.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_inputs()
	
func _physics_process(delta: float) -> void:
	# this is jank. the correlation between delta and acceleration is not linear!
	_movement = lerp(_movement, _movement_target, acceleration * delta)
	move_and_slide(_movement)
	
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

