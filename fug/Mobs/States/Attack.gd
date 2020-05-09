extends MobState


func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_animator.play("Attack")
	var anim_time = get_animation_time(_animator, "Attack")
	
	_callback(funcref(controller, "change_to"), ["Target"], anim_time)
	# yield(get_tree().create_timer(anim_time), "timeout")
	# controller.change_to("Target")

