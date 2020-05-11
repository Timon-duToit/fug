extends Area2D

class_name GrapplingHook

signal done
signal drop_body

onready var collider : CollisionShape2D = $Area
onready var idle_position : Node2D = $IdlePosition
onready var _state_machine : StateMachine = $StateMachine

var _grappled_body : Node
var _previous_body_parent : Node
var _previous_collision_mask : int
var _previous_collision_layer : int

func set_collider_disabled(value : bool) -> void:
	collider.set_deferred("disabled", value)

func attack() -> void:
	_state_machine.change_to("Attacking")

func _on_Body_death() -> void:
	# drop body and if shielding change state
	if has_body():
		drop_body()
	if _state_machine.state.name == "Shield":
		_state_machine.change_to("Idle")

func grab_body(body : Node) -> void:
	call_deferred("_grab_body", body)
	if body.has_signal("death"):
		body.connect("death", self, "_on_Body_death")

func _grab_body(body : Node) -> void:
	# HACK: clean this up
	var glob_pos = body.global_position
	var glob_rot = body.global_rotation
	_grappled_body = body
	_previous_body_parent = body.get_parent()
	_previous_body_parent.remove_child(body)
	collider.add_child(body)
	body.global_position = glob_pos
	body.global_rotation = glob_rot

	# change collision mask
	var body_physics_body := body as PhysicsBody2D
	if not body_physics_body : return
	_previous_collision_mask = body_physics_body.collision_mask
	_previous_collision_layer = body_physics_body.collision_layer
	body_physics_body.collision_mask = 0
	body_physics_body.collision_layer = 16

func drop_body() -> void:
	call_deferred("_drop_body")
	if _grappled_body.has_signal("death"):
		_grappled_body.disconnect("death", self, "_on_Body_death")
	emit_signal("drop_body")

func _drop_body() -> void:
	# changing the parents will call all collisions
	if not has_body(): return
	# HACK: clean this up

	# this makes check if this has grappled somthing return false in case collisons are triggered when dropping
	# the body
	var grappled_body := _grappled_body
	_grappled_body = null

	
	var glob_pos = grappled_body.global_position
	var glob_rot = grappled_body.global_rotation
	grappled_body.get_parent().remove_child(grappled_body)
	_previous_body_parent.add_child(grappled_body)
	grappled_body.global_position = glob_pos
	grappled_body.global_rotation = glob_rot
	_previous_body_parent = null
	
	# change collision mask back
	# NOTE: this assumes that the body node type has not changed
	var body_physics_body := grappled_body as PhysicsBody2D
	if not body_physics_body : return
	body_physics_body.collision_mask = _previous_collision_mask
	body_physics_body.collision_layer = _previous_collision_layer

func has_body() -> bool:
	return _grappled_body != null

#func hide() -> void:
#	_collider.hide()
#
#func show() -> void:
#	_collider.show()
