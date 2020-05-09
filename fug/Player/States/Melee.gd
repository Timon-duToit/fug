extends MoveState

export var melee_time := 0.5

onready var _sword := owner.get_node("Body/Sword")

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	# do attack
	_animator.play("Attack")
	_sword.attack()
	_callback(funcref(controller, "change_to"), ["Default"], melee_time)
	# yield(get_tree().create_timer(melee_time), "timeout")
	# controller_.change_to("Default")
