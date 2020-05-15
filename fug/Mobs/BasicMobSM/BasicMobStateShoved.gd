extends BasicMobStateDeath

export var friction : float = 600
export var hit_velocity_loss : float = 10
export var min_kill_velocity = 200

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.die()
	_mob.body_weapon.attack()
	_mob.movement_controller.active_move = false
	_mob.movement_controller.friction = friction

func leave() -> void:
	.leave()
	_mob.body_weapon.interrupt_attack()

func physics_process(delta : float) -> void:
	var speed := _mob.movement_controller.get_speed()
	if _mob.body_weapon.is_attacking && speed < min_kill_velocity:
		_mob.body_weapon.interrupt_attack()
	if speed == 0:
		_end_shove()
		return

func _end_shove() -> void:
	controller.change_to("Death")
