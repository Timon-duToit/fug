extends MoveState

func process(delta : float) -> void:
	.process(delta)

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		controller.change_to("Melee")
