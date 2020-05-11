extends GrapplingHookState

export var max_range : float = 400
export var attack_time : float = 0.5
export var attack_curve : Curve

var _target_position : Vector2

onready var _attack_animation := AnimatedCurve.new(attack_curve, attack_time)

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	grappling_hook.show()
	grappling_hook.set_collider_disabled(false)
	_target_position = grappling_hook.get_global_mouse_position()
	_attack_animation.reset()
	_target_position - grappling_hook.get_global_mouse_position()
	_enforce_max_range()

func physics_process(delta : float) -> void:
	var done_attacking := _attack_animation.update(delta)
	_target_position = update_target_position(delta, _target_position)
	_enforce_max_range()
	var normalized_position = _attack_animation.value
	var hook_to_target := _target_position - grappling_hook.global_position
	grappling_hook.collider.position = Vector2.RIGHT * hook_to_target.length() * normalized_position
	grappling_hook.rotation = hook_to_target.angle()
	
	if done_attacking:
		controller.change_to("Retracting")
	# return done_attacking

func on_Parent_body_entered(body: Node) -> void:
	if body.has_method("get_grappled"):
		body.get_grappled()
		grappling_hook.grab_body(body)
		controller.change_to("Retracting")

func _enforce_max_range() -> void:
	# moves target position so that it stays in max range.
	# Might be weird while dashing and thuse need to be replaced by something different.
	var hook_to_target := _target_position - grappling_hook.global_position
	if hook_to_target.length() > max_range:
		_target_position = hook_to_target.normalized() * max_range + grappling_hook.global_position
