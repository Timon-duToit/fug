extends PlayerDefault

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	controller.change_to("Shield")

func unhandled_input(event : InputEvent) -> void:
	pass
