extends PlayerDefault

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.grappling_hook.connect("drop_body", self, "_on_GrapplingHook_done")

func leave() -> void:
	.leave()
	player.grappling_hook.disconnect("drop_body", self, "_on_GrapplingHook_done")

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		var mob := (player.grappling_hook._grappled_body as Mob)
		if mob:
			mob.hit()
	elif event.is_action_pressed("alt_attack"):
		controller.change_to("Mace")

func _on_GrapplingHook_done() -> void:
	controller.change_to("Default")
