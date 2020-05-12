extends GrapplingHookState

export var retract_curve : Curve
export var retract_time : float = 0.5
export var min_retract_time : float = 0.3
# the distance to which the retraction time is calculated
export var nominated_retract_dist : float = 100

var _target_position : Vector2
var _body_relative_start_position : Vector2

onready var _retract_animation : AnimatedCurve

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_target_position = grappling_hook.collider.global_position
	
	# HACK: this might not get called
	if grappling_hook._grappled_body:
		_body_relative_start_position = grappling_hook._grappled_body.position
	var _retract_time = retract_time * (_target_position - grappling_hook.global_position).length() / nominated_retract_dist
	_retract_time = max(min_retract_time, _retract_time)
	_retract_animation = AnimatedCurve.new(retract_curve, _retract_time)
	_retract_animation.reset()
	
func process(delta : float) -> void:
	update_line_renderer()

func physics_process(delta : float) -> void:
	var done := _retract_animation.update(delta)
	_target_position = update_target_position(delta, _target_position)
	# TODO: perhaps just lerp the position and don't use curve?
	var hook_to_target := _target_position - grappling_hook.idle_position.global_position
	var normalized_position = _retract_animation.value
	grappling_hook.collider.position = Vector2.RIGHT * hook_to_target.length() * normalized_position + grappling_hook.idle_position.position
	grappling_hook.rotation = hook_to_target.angle()

	if grappling_hook._grappled_body:
		grappling_hook._grappled_body.position = _body_relative_start_position * _retract_animation.value
	
	if done:
		grappling_hook.emit_signal("done")
		if grappling_hook.has_body():
			controller.change_to("Shield")
		else:
			controller.change_to("Idle")

func on_Parent_body_entered(body: Node) -> void:
	if grappling_hook.has_body(): return
	if body.has_method("get_grappled"):
		body.get_grappled()
		grappling_hook.grab_body(body)
