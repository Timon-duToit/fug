extends PlayerState

func enter(controller_ : StateMachine) -> void:
	print("DEATH DEATH")
	.enter(controller_)
	_animator.play("Death")
	_collider
