extends Area2D

export var attack_time : float = 0.2

var _attacking := false
var _attack_time : float

onready var _collider := $Area

func _ready() -> void:
	_collider.disabled = true


func _process(delta : float) -> void:
	if not _attacking: return
	
	_attack_time += delta
	if _attack_time >= attack_time:
		_stop_attack()
	

func _physics_process(delta: float) -> void:
	if _attacking:
		_attack_physics_process(delta)


func _on_Punch_body_entered(body: Node) -> void:
	# TODO: damage calculation / other stuff here. This will probably just be
	# overwritten by the children
	
	# Maybe this should be replaced by some sort of hittable interface / class
	if body.has_method("hit"):
		body.hit()
	
	
func attack() -> void:
	print("ATTACKING")
	_collider.set_deferred("disabled", false)
	_attacking = true
	_attack_time = 0


func _stop_attack() -> void:
	_attacking = false
	_collider.set_deferred("disabled", true)


func _attack_physics_process(delta : float) -> void:
	# This method will be overwritten by children do modify the colliders etc.
	pass
