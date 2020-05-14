extends MobState

export var attack_delay : float = 0.2

onready var _weapon := owner.get_node("Punch")

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	mob.play_animation("Attack")
	# _weapon.attack()
	
	var anim_time = Util.get_animation_time(mob.animator, "Attack")
	if anim_time <= attack_delay:
		print("ERROR: won't attack if animation time is less then attack_delay")
	
	_callback(funcref(_weapon, "attack"), attack_delay)
	_callback(funcref(controller, "change_to"), anim_time, ["Target"])
	# yield(get_tree().create_timer(anim_time), "timeout")
	# controller.change_to("Target")
