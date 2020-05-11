extends PlayerDefault

export var shove_strength : float = 350

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.grappling_hook.connect("drop_body", self, "_on_GrapplingHook_drop_body")

func leave() -> void:
	.leave()
	player.grappling_hook.disconnect("drop_body", self, "_on_GrapplingHook_drop_body")

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		var body := player.grappling_hook._grappled_body
		if body:
			player.grappling_hook.drop_body()
		if body.has_method("get_shoved"):
			body.get_shoved(player.get_global_mouse_position() - body.global_position, shove_strength)
	elif event.is_action_pressed("alt_attack"):
		controller.change_to("Mace")

func _on_GrapplingHook_drop_body() -> void:
	controller.change_to("Default")
