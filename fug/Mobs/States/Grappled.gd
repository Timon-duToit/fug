extends MobState

func enter(controller_ : StateMachine):
	.enter(controller_)
	mob.play_animation("Idle")
	mob.set_collider_disabled(true)
