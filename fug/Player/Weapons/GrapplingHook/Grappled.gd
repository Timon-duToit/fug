extends GrapplingHookState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	grappling_hook.grappled_actor.be_shield()
	grappling_hook.connect("drop_body", self, "_on_GrapplingHook_drop_body")

func leave() -> void:
	.leave()
	grappling_hook.disconnect("drop_body", self, "_on_GrapplingHook_drop_body")

func physics_process(delta : float) -> void:
	# HACK: somehow chang thi
	grappling_hook.look_at(grappling_hook.get_global_mouse_position())

func _on_GrapplingHook_drop_body() -> void:
	controller.change_to("Idle")
