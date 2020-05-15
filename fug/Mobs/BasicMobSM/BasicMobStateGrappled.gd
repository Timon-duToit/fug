extends State

onready var _mob : BasicMob = owner as BasicMob

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.play_animation("Idle")
	_mob.movement_controller.enabled = false

func leave() -> void:
	.leave()
	_mob.movement_controller.enabled = true
