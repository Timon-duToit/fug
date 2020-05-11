extends MobState

func enter(controller_ : StateMachine):
	.enter(controller_)
	mob.play_animation("Idle")
