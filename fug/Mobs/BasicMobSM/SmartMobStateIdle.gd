extends State

export var min_wait_time : float = 1
export var max_wait_time : float = 10

onready var _mob : BasicMob = owner as BasicMob

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.movement_controller.stop()
	_mob.play_animation("Idle")
	_callback(funcref(self, "_continue_walking"), rand_range(min_wait_time, max_wait_time))

func physics_process(delta: float) -> void:
	if _mob.can_see_player():
		change_to("Target")

func _continue_walking() -> void:
	_mob.rotation = _mob.pick_walk_direction(3, 500)
	change_to("Walk")
