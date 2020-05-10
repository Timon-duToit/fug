extends MoveState

export var melee_time : float = 0.5
export var start_delay : float = 0.2

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	# do attack
	player.play_animation("Attack")
	_callback(funcref(player.sword, "attack"), [], start_delay)
	_callback(funcref(controller, "change_to"), ["Default"], melee_time)
	# yield(get_tree().create_timer(melee_time), "timeout")
	# controller_.change_to("Default")

func unhandled_input(event : InputEvent) -> void:
	# TODO: check some global dash timeout
	# you can also dash if the attack began in limbo
	var can_dash = player.can_dash || controller.last_state == "Limbo"
	if event.is_action_pressed("dash") && can_dash:
		controller.change_to("Shove")
