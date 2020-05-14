extends MobWeapon

class_name BodyWeapon

onready var _collider = $Area/Collider

func _ready() -> void:
	_collider.set_deferred("disabled", true)

func attack(on_hit_callback := funcref(self, "_on_hit_default")):
	.attack(on_hit_callback)
	_collider.set_deferred("disabled", false)

func attack_done() -> void:
	.attack_done()
	_collider.set_deferred("disabled", true)

func _on_Area_body_entered(body: Actor) -> void:
	if not body: return
	on_hit(body)
