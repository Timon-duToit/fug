extends PlayerState

# For now this mode can only be accessed via attack -> dash

export var dash_dist : float = 120
export var dash_time : float = 0.5
export var dash_curve : Curve = Curve.new()

var _direction : Vector2
# the distance moved through the curve (normalized)
var _curve_position : float


func _on_Sword_hit():
	controller.change_to("Default")


func enter(controller_ : StateMachine) -> void:
	# HACK: there should be a better way to do these references
	_player.sword.connect("hit", self, "_on_Sword_hit")
	.enter(controller_)
	_animator.play("Shove")
	_player.sword.shove()
	_direction = Vector2()
	if Input.is_action_pressed("up"):
		_direction += Vector2.UP
	if Input.is_action_pressed("down"):
		_direction += Vector2.DOWN
	if Input.is_action_pressed("right"):
		_direction += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		_direction += Vector2.LEFT
	_direction = _direction.normalized()
	owner.body.rotation = Vector2.RIGHT.angle_to(_direction)
	_curve_position = 0


func physics_process(delta : float) -> void:
	# calcualte difference between last distance traveled and new distance traveled
	# and move by that much.
	var new_curve_position = _curve_position + delta / dash_time
	var new_distance := dash_curve.interpolate(new_curve_position)
	var last_distance := dash_curve.interpolate(_curve_position)
	_curve_position = new_curve_position
	var delta_normalized := new_distance - last_distance
	if owner.move_and_collide(_direction * delta_normalized * dash_dist):
		controller.change_to("Default")
		
	if new_curve_position >= 1:
		controller.change_to("Default")
