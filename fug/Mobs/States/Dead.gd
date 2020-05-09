extends MobState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	if _animator.animation != "Death":
		_animator.play("Death")
		_animator.rotate(PI)
	_collider.set_deferred("disabled", true)
	yield(get_tree().create_timer(1), "timeout")
	
	# todo: replce with corpse sprite node
	_animator.modulate = Color(0.75, 0.75, 0.125, 1)
