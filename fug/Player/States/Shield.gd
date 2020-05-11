extends PlayerDefault

func unhandled_input(event : InputEvent) -> void:
	.unhandled_input(event)
	if event.is_action_pressed("attack"):
		player.grappling_hook.release()
