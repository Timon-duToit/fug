extends Area2D

# TODO: change to inherit Weapon

export var sweep := -PI
export var start_delay : float = 0.2
export var sweep_time : float = 0.1

var _attacking := false
var _sweep_time : float

onready var _collider := $CollisionPolygon2D

func _ready() -> void:
	_collider.disabled = true
	
func attack() -> void:
	yield(get_tree().create_timer(start_delay), "timeout")
	_collider.set_deferred("disabled", false)
	_attacking = true
	_sweep_time = 0

# I could also use a timer to update this slower
func _physics_process(delta: float) -> void:
	if not _attacking: return
	_sweep_time += delta
	if _sweep_time >= sweep_time:
		_collider.set_deferred("disabled", true)
		_attacking = false
	else:
		_collider.rotation = lerp(0, sweep, _sweep_time / sweep_time)


func _on_Sword_body_entered(body: Node) -> void:
	if body is Mob:
		body.hit()
