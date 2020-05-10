extends MobState

func enter(controller_ : StateMachine):
	.enter(controller_)
	mob.play_animation("Idle")
	mob.collision_mask = 0
	mob.collision_layer = 16
	# mob.set_collider_disabled(true)
