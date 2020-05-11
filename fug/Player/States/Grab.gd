extends MoveState

export var start_delay : float = 0.2

var _is_attacking := false

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.grappling_hook.attack()
	player.grappling_hook.connect("done", self, "_on_GrapplingHook_done")

func leave() -> void:
	.leave()
	player.grappling_hook.disconnect("done", self, "_on_GrapplingHook_done")	

func process(delta : float) -> void:
	.process(delta)
	if _is_attacking : return
	if player._movement.length() > 5:
		player.play_animation("Walking")
	else:
		player.play_animation("Idle")

func _on_GrapplingHook_done() -> void:
	if player.grappling_hook.is_holding():
		controller.change_to("Shield")
	else:
		controller.change_to("Default")

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_is_attacking = true
		player.play_animation("Attack")
		_callback(funcref(player.sword, "attack"), [], start_delay)
