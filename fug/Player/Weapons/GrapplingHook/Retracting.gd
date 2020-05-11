extends GrapplingHookState

export var retract_curve : Curve
export var retract_time : float = 0.2

var _target_position : Vector2
var _body_relative_start_position : Vector2

onready var _retract_animation := AnimatedCurve.new(retract_curve, retract_time)

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_target_position = grappling_hook.collider.global_position
	_retract_animation.reset()
	
	if grappling_hook.has_body():
		_body_relative_start_position = grappling_hook._grappled_body.position

func physics_process(delta : float) -> void:
	var done := _retract_animation.update(delta)
	_target_position = update_target_position(delta, _target_position)
	# TODO: perhaps just lerp the position and don't use curve?
	var hook_to_target := _target_position - grappling_hook.idle_position.global_position
	var normalized_position = _retract_animation.value
	grappling_hook.collider.position = Vector2.RIGHT * hook_to_target.length() * normalized_position + grappling_hook.idle_position.position
	grappling_hook.rotation = hook_to_target.angle()

	if grappling_hook.has_body():
		grappling_hook._grappled_body.position = _body_relative_start_position * _retract_animation.value
	
	if done:
		grappling_hook.emit_signal("done")
		if grappling_hook.has_body():
			controller.change_to("Shield")
		else:
			controller.change_to("Idle")
