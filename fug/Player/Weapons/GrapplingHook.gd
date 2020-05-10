extends Weapon

class_name GrapplingHook

export var max_range : float = 800
export var position_curve_ : Curve
export var reaction_curve : Curve
export var reaction_curve_domain : float = 80
export var max_change_speed : float = 30

var target_position : Vector2

onready var _position_curve := AnimatedCurve.new(position_curve_, attack_time)

func _ready() -> void:
	_collider.hide()

func attack() -> void:
	.attack()
	_collider.show()
	_position_curve.reset()
	target_position = get_global_mouse_position()

func stop_attack() -> void:
	.stop_attack()
	_collider.hide()

func _on_body_entered(body : Node) -> void:
	if body is Mob:
		var parent = body.get_parent()
		parent.remove_child(body)
		parent.add_child(body)
		# parent.call_deferred("add_child", body)
		body._state_machine.change_to("Grappled")

func _reparent_body(body : Node) -> void:
	body.get_parent().remove_child(body)
	_collider.add_child(body)

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
			
			
func _physics_process(delta : float) -> void:
	if not _attacking: return
	_position_curve.update(delta)
	_update_target_position(delta)
	
	var normalized_position = _position_curve.value
	var delta_vector = target_position - owner.position
	position = delta_vector * normalized_position
	rotation = delta_vector.angle()
