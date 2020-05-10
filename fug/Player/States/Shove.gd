extends PlayerState

# For now this mode can only be accessed via attack -> dash

export var dash_time : float = 0.5

var _direction : Vector2
# the distance moved through the curve (normalized)
var _curve_position : float


func _on_Sword_hit():
	# this will call a change state here via the message
	controller.change_to("Limbo")
	
func enter(controller_ : StateMachine) -> void:
	# HACK: there should be a better way to do these references
	player.sword.connect("hit", self, "_on_Sword_hit")
	player.sword.shove()
	.enter(controller_)
	player.play_animation("Shove")
	_direction = Vector2()
	if Input.is_action_pressed("up"):
		_direction += Vector2.UP
	if Input.is_action_pressed("down"):
		_direction += Vector2.DOWN
	if Input.is_action_pressed("right"):
		_direction += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		_direction += Vector2.LEFT
	_direction = _direction.normalized()
	player.dash(_direction, dash_time)
	player.body_target = _direction
	player.connect("state_change", self, "on_Player_state_change")

func leave() -> void:
	.leave()
	# disconnect before changing player state
	player.disconnect("state_change", self, "on_Player_state_change")
	player.change_state(Player.MOVING)
	player.sword.stop_attack()
	player.sword.disconnect("hit", self, "_on_Sword_hit")
	
func on_Player_state_change(new_state) -> void:
	# player has ended the dash himself
	if new_state != Player.DASHING:
		controller.change_to("Default")
