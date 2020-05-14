extends Actor

onready var _animator := $Animator
onready var _collider := $Collider

func die() -> void:
	.die()
	_animator.play("Death")

func shoved(impulse : Vector2) -> void:
	die()
