extends KinematicBody2D

class_name Actor

export var max_hp : int = 100

var _hp : int = max_hp

func hit(damage : int) -> void:
	_hp = max(0, _hp - damage)
	if _hp == 0:
		die()

func die() -> void:
	pass

func shoved(impulse : Vector2) -> void:
	pass

func be_shield() -> void:
	pass

func be_weapon() -> void:
	pass

func be_grappled() -> bool:
	# returns true if the grapple has succeeded
	return false

func burn(damage : int) -> void:
	pass
