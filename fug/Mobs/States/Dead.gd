extends MobState

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	if mob.animator.animation != "Death":
		mob.play_animation("Death")
		mob.animator.rotate(PI)
	mob.set_collider_disabled(true)
	mob.animator.z_index = -20
	
	_callback(funcref(self, "_set_death_colors"), [], 1)

func _set_death_colors() -> void:
	mob.animator.modulate = Color(0.75, 0.75, 0.125, 1)
