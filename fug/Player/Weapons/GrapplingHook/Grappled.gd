extends GrapplingHookState

func physics_process(delta : float) -> void:
	# HACK: somehow chang thi
	grappling_hook.look_at(grappling_hook.get_global_mouse_position())
