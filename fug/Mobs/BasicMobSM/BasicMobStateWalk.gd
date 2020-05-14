extends State

export var speed : float = 100
export var target_distance : float = 250

onready var _mob : BasicMob = owner as BasicMob

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.play_animation("Walk")
	_mob.movement_controller.speed_target = Vector2.RIGHT.rotated(_mob.rotation) * speed

func physics_process(delta: float) -> void:
	var player := GameManager.player
	var dist = (player.global_position - _mob.global_position).length()
	if dist < target_distance:
		controller.change_to("Target")
