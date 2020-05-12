extends MoveState

export var shove_strength : float = 650
export var start_delay : float = 0.2
var _is_attacking := false

onready var _sound_shove = $SoundShove

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.sword.connect("hit", self, "_on_Sword_hit")
	player.grappling_hook.connect("done", self, "_on_GrapplingHook_done")
	player.grappling_hook.mace()

func leave() -> void:
	.leave()
	player.grappling_hook.disconnect("done", self, "_on_GrapplingHook_done")
	player.sword.disconnect("hit", self, "_on_Sword_hit")

func process(delta : float) -> void:
	.process(delta)
	if _is_attacking : return
	if player._movement.length() > 5:
		player.play_animation("Walking")
	else:
		player.play_animation("Idle")

func _on_GrapplingHook_done() -> void:
	controller.change_to("Shield")

func unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_is_attacking = true
		player.play_animation("Attack")
		_callback(funcref(player.sword, "attack"), [], start_delay)

func _on_Sword_hit(body : Mob) -> void:
	if not body: return
	if body == player.grappling_hook._grappled_body:
		player.grappling_hook.drop_body()
		body.get_shoved(player.get_global_mouse_position() - body.global_position, shove_strength)
		GameManager.slowdown()
		_sound_shove.play()
