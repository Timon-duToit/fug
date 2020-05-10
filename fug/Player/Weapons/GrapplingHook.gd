extends Weapon

class_name GrapplingHook

export var max_range : float = 800
export var position_curve_ : Curve
export var reaction_curve : Curve
export var lerping_speed : float = 1

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
	print("here====================")

func _physics_process(delta : float) -> void:
	if not _attacking: return
	
	_position_curve.update(delta)
	# TODO: do a raycast do check if hitting walls
	var normalized_position = _position_curve.value
	# TODO: lerp the actual_target_position (maybe the angle whatever feels more natural)
	
	var offset_vector :=  get_global_mouse_position() - target_position
	var offset_distance := offset_vector.length()
	
	if offset_distance:
		var offset_movement = lerp(0, offset_distance, delta * lerping_speed)
		print((offset_vector / offset_distance * offset_movement).length())
		target_position += offset_vector / offset_distance * offset_movement
	
	var delta_vector = target_position - owner.position
	position = delta_vector * normalized_position
	rotation = delta_vector.angle()
