extends PlayerState

class_name MoveState

func enter(controller_: StateMachine) -> void:
	.enter(controller_)
	player.play_animation("Idle")

func process(delta : float) -> void:
	.process(delta)
	_handle_inputs()

func _handle_inputs() -> void:
	var _movement_target := Vector2()
	if Input.is_action_pressed("up"):
		_movement_target += Vector2.UP
	if Input.is_action_pressed("down"):
		_movement_target += Vector2.DOWN
	if Input.is_action_pressed("right"):
		_movement_target += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		_movement_target += Vector2.LEFT
	_movement_target = _movement_target.normalized() * player.speed
	player.movement_target = _movement_target
	player.body_look_at(player.get_global_mouse_position())
