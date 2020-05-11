extends PlayerDefault

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.grappling_hook.mace()

func unhandled_input(event : InputEvent) -> void:
	pass
