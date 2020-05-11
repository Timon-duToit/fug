extends PlayerDefault

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		controller.change_to("Melee")
		player.grappling_hook.release()
#	elif event.is_action_pressed("dash") && player.can_dash:
#		controller.change_to("Dash")
	elif event.is_action_pressed("alt_attack"):
		controller.change_to("Mace")
