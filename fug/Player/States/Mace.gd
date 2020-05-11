extends PlayerDefault

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	return
	player.grappling_hook.mace()

func unhandled_input(event : InputEvent) -> void:
	pass
