extends PlayerState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_animator.play("Death")
