extends PlayerDefault

export var limbo_time : float = 0.4

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_callback(funcref(controller, "change_to"), ["Default"], limbo_time)
	
func unhandled_input(event : InputEvent) -> void:
	.unhandled_input(event)
	if event.is_action_pressed("dash"):
		# it does not matter if player can dash
		controller.change_to("Dash")
