extends Area2D

class_name GrapplingHook

signal hit
signal done

export var max_range : float = 800

export var attack_time : float = 0.2
export var attack_curve : Curve
export var retract_curve : Curve
export var retract_time : float = 0.2

export var reaction_curve : Curve
export var reaction_curve_domain : float = 80
export var max_change_speed : float = 30

enum {IDLE, ATTACKING, RETRACTING, GRAPPLED}

var target_position : Vector2
var _state := IDLE

var _grappled_body : Node
var _previous_body_parent : Node
var _body_start_drag_position : Vector2

onready var _attack_animation := AnimatedCurve.new(attack_curve, attack_time)
onready var _retract_animation := AnimatedCurve.new(retract_curve, retract_time)

onready var _collider : CollisionShape2D = $Area

func _ready() -> void:
	_collider.hide()
	_collider.disabled = true

func attack() -> void:
	if _state == IDLE:
		_collider.show()
		_collider.set_deferred("disabled", false)
		_state = ATTACKING
	_attack_animation.reset()
	_retract_animation.reset()
	target_position = get_global_mouse_position()

func stop_attack() -> void:
	if _state == ATTACKING:
		_collider.hide()

func release() -> void:
	if not _state == GRAPPLED: return
	_state = IDLE
	_collider.hide()
	if _grappled_body.has_method("release"):
		_grappled_body.release()
	_drop_body()

func _on_body_entered(body : Node) -> void:
	# HACK: This method will get called a couple of times due to multiple collisions
	# -> disable collisions between mob and this faster?#
	if _state == ATTACKING && body.has_method("get_grappled"):
		target_position = _collider.global_position
		print("T: ", target_position)
		emit_signal("hit")
		_state = RETRACTING
		_collider.set_deferred("disabled", true)
		_grappled_body = body
		_reparent_body(body)
		_body_start_drag_position = body.position
		body.get_grappled()

func _reparent_body(body : Node) -> void:
	# this way of preserving relative position is a bit hacky
	var glob_pos = body.global_position
	var glob_rot = body.global_rotation
	_previous_body_parent = body.get_parent()
	_previous_body_parent.remove_child(body)
	_collider.add_child(body)
	body.global_position = glob_pos
	body.global_rotation = glob_rot
	# _collider.call_deferred("add_child", body)

func _drop_body() -> void:
	var glob_pos = _grappled_body.global_position
	var glob_rot = _grappled_body.global_rotation
	_grappled_body.get_parent().remove_child(_grappled_body)
	_previous_body_parent.add_child(_grappled_body)
	_grappled_body.global_position = glob_pos
	_grappled_body.global_rotation = glob_rot
	_grappled_body = null
	_previous_body_parent = null

func _get_target_move_speed(target_distance : float) -> float:
	if target_distance > reaction_curve_domain:
		return max_change_speed
	return reaction_curve.interpolate(target_distance / reaction_curve_domain) * max_change_speed

func _update_target_position(delta : float) -> void:
	# todo: update angle and distance seperately
	var offset_vector :=  get_global_mouse_position() - target_position
	var offset_distance := offset_vector.length()
	
	if offset_distance:
		var target_move := _get_target_move_speed(offset_distance) * offset_vector.normalized() * delta
		if target_move.length() > offset_distance:
			target_position += offset_vector
		else:
			target_position += target_move

func _grappled_physics_process(delta : float) -> void:
	# HACK:
	look_at(get_global_mouse_position() - position)

func _physics_process(delta : float) -> void:
	match _state:
		GRAPPLED:
			_grappled_physics_process(delta)
		ATTACKING:
			var done_attacking := _attack_animation.update(delta)
			_update_target_position(delta)
			var normalized_position = _attack_animation.value
			var delta_vector = target_position - owner.position
			position = delta_vector * normalized_position
			rotation = delta_vector.angle()
			if done_attacking:
				_state = RETRACTING
		RETRACTING:
			# draw body in according to same curve.
			var done := _retract_animation.update(delta)
			# TODO: perhaps just lerp the position and don't use curve?
			var delta_vector = target_position - owner.position
			position = delta_vector * _retract_animation.value
			rotation = delta_vector.angle()
			
			if _grappled_body:
				_grappled_body.position = _body_start_drag_position * _retract_animation.value
			if done:
				emit_signal("done")
				if _grappled_body:
					_state = GRAPPLED
				else:
					_state = IDLE
