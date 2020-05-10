extends MoveState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.grappling_hook.attack()
	player.grappling_hook.connect("done", self, "_on_GrapplingHook_done")

func leave() -> void:
	.leave()
	player.grappling_hook.disconnect("done", self, "_on_GrapplingHook_done")	

func process(delta : float) -> void:
	.process(delta)
	if player._movement.length() > 5:
		player.play_animation("Walking")
	else:
		player.play_animation("Idle")

func _on_GrapplingHook_done() -> void:
	controller.change_to("Default")

#func unhandled_input(event : InputEvent) -> void:
#	if event.is_action_pressed("attack"):
#		controller.change_to("Melee")
#	elif event.is_action_pressed("dash") && player.can_dash:
#		controller.change_to("Dash")
