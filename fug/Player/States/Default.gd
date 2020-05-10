extends MoveState

export var dash_timeout : float = 1

var _can_dash : bool


func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	# Maybe we should have a global dash timeout instead
	if controller.last_state == "Dash":
		_can_dash = false
		_callback(funcref(self, "_allow_dash"), [], dash_timeout)
	else:
		_can_dash = true


func process(delta : float) -> void:
	.process(delta)
	if player._movement.length() > 5:
		player.play_animation("Walking")
	else:
		player.play_animation("Idle")


func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		controller.change_to("Melee")
	elif _can_dash && event.is_action_pressed("dash"):
		controller.change_to("Dash")


func _allow_dash() -> void:
	_can_dash = true
