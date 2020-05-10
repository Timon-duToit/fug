extends KinematicBody2D

class_name Player

signal state_change(new_state)

export var speed : float = 150
export var acceleration : float = 20

export var dash_dist : float = 120
export var dash_time : float = 0.2
export var dash_curve : Curve = Curve.new()

onready var state_machine := $StateMachine
onready var body := $Body
onready var sword := $Body/Sword
onready var animator := $Body/Animator

onready var _collider := $CollisionShape2D

enum { IDLE, MOVING, DASHING }

var _state = MOVING

var movement_target := Vector2()
# The vector gives the direction that the player is looking in.
var body_target := Vector2()
var _movement := Vector2()

var _dash_direction : Vector2
var _dash_time : float
var _dash_curve_position : float

func _physics_process(delta : float) -> void:
	# aim body to camera
	body.rotation = lerp(body.rotation, body_target.angle(), 20 * delta)
	if _state == MOVING:
		_movement = lerp(_movement, movement_target, acceleration * delta)
		move_and_slide(_movement)
	elif _state == DASHING:
		var new_curve_position = min(1, _dash_curve_position + delta / _dash_time)
		var new_distance := dash_curve.interpolate(new_curve_position)
		var last_distance := dash_curve.interpolate(_dash_curve_position)
		_dash_curve_position = new_curve_position
		var delta_normalized := new_distance - last_distance

		var has_hit = move_and_collide(_dash_direction * delta_normalized * dash_dist)
		if has_hit || new_curve_position == 1:
			change_state(MOVING)

func die() -> void:
	change_state(IDLE)

func change_state(new_state) -> void:
	_state = new_state
	emit_signal("state_change", _state)

func hit() -> void:
	state_machine.change_to("Death")

func play_animation(name : String) -> void:
	animator.play(name)

func set_collider_disabled(state : bool) -> void:
	_collider.set_deferred("disabled", state)

func body_look_at(point : Vector2) -> void:
	body_target = point - position

func dash(_direction : Vector2, time := dash_time) -> void:
	_dash_direction = _direction
	_dash_time = time
	_dash_curve_position = 0
	change_state(DASHING)
