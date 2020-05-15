extends BasicMobStateDeath

export var hit_velocity_loss : float = 10
export var min_kill_velocity = 200

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.body_weapon.attack()
	_mob.movement_controller.mode = BasicMobMC.Mode.FRICTION

func leave() -> void:
	.leave()
	_mob.movement_controller.mode = BasicMobMC.Mode.CONTROL
	_mob.body_weapon.interrupt_attack()

func physics_process(delta : float) -> void:
	var speed := _mob.movement_controller.get_speed()
	
	# Velocity loss on inital collision (with wall)
	if _mob.movement_controller.has_collided && ! _mob.movement_controller.has_collided_last_update:
		_mob.movement_controller.slowdown(_mob.movement_controller.get_speed() / 2)
	
	if _mob.body_weapon.is_attacking && speed < min_kill_velocity:
		_mob.body_weapon.interrupt_attack()
	if speed == 0:
		_end_shove()
		return

func _end_shove() -> void:
	controller.change_to("Death")
