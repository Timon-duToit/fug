extends Area2D

# TODO: change to inherit Weapon

class_name Sword

signal hit(body)
signal done

enum Type {ATTACK, SHOVE}

export var shove_strength : float = 400
export var sweep := -PI
export var sweep_time : float = 0.1

var _attacking := false
var _attack_time : float
# collider state and onhit reaction state
var _state = Type.ATTACK

onready var _collider_attack := $ColliderAttack
onready var _collider_shove := $ColliderShove


func _ready() -> void:
	_collider_attack.disabled = true
	_collider_shove.disabled = true

	
func attack() -> void:
	_state = Type.ATTACK
	# TODO: remove and replace with state timeout
	_collider_attack.set_deferred("disabled", false)
	_attacking = true
	_attack_time = 0

func stop_attack() -> void:
	_attacking = false
	if _state == Type.ATTACK:
		_collider_attack.set_deferred("disabled", true)
	else:
		_collider_shove.set_deferred("disabled", true)
	emit_signal("done")

func shove() -> void:
	_state = Type.SHOVE
	_collider_shove.set_deferred("disabled", false)
	_attacking = true
	_attack_time = 0

# I could also use a timer to update this slower
func _physics_process(delta: float) -> void:
	if not _attacking: return
	_attack_time += delta
	
	if _state == Type.ATTACK:
		if _attack_time >= sweep_time:
			stop_attack()
		else:
			_collider_attack.rotation = lerp(0, sweep, _attack_time / sweep_time)

func _on_Sword_body_entered(body: Node) -> void:
	emit_signal("hit", body)
#	if _type == Type.ATTACK && body.has_method("hit"):
#		body.hit()
#		emit_signal("hit")
#	elif _type == Type.SHOVE && body.has_method("get_shoved"):
#		body.get_shoved(global_position, global_rotation, shove_strength)
#		emit_signal("hit")
