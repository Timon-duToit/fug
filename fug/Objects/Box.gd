extends Actor

onready var _animator := $Animator
onready var _collider := $Collider

func die() -> void:
	_animator.playe("Death")
	_collider.set_deferred("disabled", true)
