extends MobState

export var friction : float = 600

var _speed : Vector2

func init_shove(other_position : Vector2, other_rotation : float, shove_strength : float) -> void:
	# Not the cleanest way to do things but hey.
	_animator.rotate(PI)
	_animator.play("Death")
	# disable collision with other mobs
	_mob.set_collision_mask_bit(2, 0)
	_mob.set_collision_layer_bit(2, 0)
	
	# for now just fling away from other position
	var dir = ((_mob.global_position - other_position) + Vector2.RIGHT.rotated(other_rotation)).normalized()
	_speed = dir * shove_strength
	_shoved_collider.set_deferred("disabled", false)
	

func physics_process(delta : float) -> void:
	if friction * delta > _speed.length():
		_end_shove()
		return

	_speed -= _speed.normalized() * friction * delta
	if _mob.move_and_collide(delta * _speed):
		_end_shove()


func _end_shove() -> void:
	_shoved_collider.set_deferred("disabled", true)
	controller.change_to("Dead")


func _on_ShoveArea_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.hit()
