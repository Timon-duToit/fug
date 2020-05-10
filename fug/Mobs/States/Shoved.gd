extends MobState

export var friction : float = 600
export var hit_velocity_loss : float = 10
export var min_kill_velocity = 200

var _speed : Vector2

func init_shove(other_position : Vector2, other_rotation : float, shove_strength : float) -> void:
	# Not the cleanest way to do things but hey.
	mob.animator.rotate(PI)
	mob.play_animation("Death")
	# disable collision with other mobs
	mob.set_collision_mask_bit(2, 0)
	mob.set_collision_layer_bit(2, 0)
	
	# for now just fling away from other position
	var dir = ((mob.global_position - other_position) + Vector2.RIGHT.rotated(other_rotation)).normalized()
	_speed = dir * shove_strength
	mob.shove_collider.set_deferred("disabled", false)

func physics_process(delta : float) -> void:
	var new_velocity = _decrease_velocity(friction * delta)
	if !mob._collider.disabled && new_velocity < min_kill_velocity:
		mob.shove_collider.set_deferred("disabled", true)
	if new_velocity == 0:
		_end_shove()
		return
	if mob.move_and_collide(delta * _speed):
		_end_shove()

func _decrease_velocity(amount : float):
	# returns the new velocity
	if amount > _speed.length():
		_speed = Vector2.ZERO
		return 0
	_speed -= _speed.normalized() * amount
	return _speed.length()

func _end_shove() -> void:
	controller.change_to("Dead")

func _on_ShoveArea_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.hit()
		_decrease_velocity(hit_velocity_loss)
