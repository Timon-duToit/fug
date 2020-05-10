extends PlayerState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	player.play_animation("Death")
	player.die()
