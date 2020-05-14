extends Area2D

class_name GrapplingHook

signal done
signal drop_body

onready var collider : CollisionShape2D = $Area
onready var idle_position : Node2D = $IdlePosition
onready var line : Line2D = $Line2D
onready var _state_machine : StateMachine = $StateMachine

var _grappled_actor : Actor
var _previous_body_parent : Node

# this is used rather then checking _grappled_body so that it updates instantly on drop_body() and not on
# the deferred call
var grappled_actor : Actor setget , get_grappled_actor
var has_actor : bool setget , get_has_actor
var _has_actor := false

func set_collider_disabled(value : bool) -> void:
	collider.set_deferred("disabled", value)

func attack() -> void:
	_state_machine.change_to("Attacking")

func mace() -> void:
	_state_machine.change_to("Macing")

func _on_Body_death() -> void:
	# drop body and if shielding change state
	if _has_actor:
		drop_actor()
	if _state_machine.state.name == "Shield":
		_state_machine.change_to("Idle")

func grab_actor(actor : Actor) -> void:
	assert(actor)
	_grappled_actor = actor
	_has_actor = true
	call_deferred("_grab_body", actor)
	actor.connect("death", self, "_on_Body_death")

func drop_actor() -> void:
	_has_actor = false
	call_deferred("_drop_body", _grappled_actor)
	_grappled_actor.disconnect("death", self, "_on_Body_death")
	_grappled_actor.be_ungrappled()
	_grappled_actor = null
	emit_signal("drop_body")

func _grab_body(actor : Actor) -> void:
	# HACK: clean this up
	var glob_pos = actor.global_position
	var glob_rot = actor.global_rotation
	_previous_body_parent = actor.get_parent()
	_previous_body_parent.remove_child(actor)
	collider.add_child(actor)
	actor.global_position = glob_pos
	actor.global_rotation = glob_rot

func _drop_body(actor : Actor) -> void:
	var glob_pos = actor.global_position
	var glob_rot = actor.global_rotation
	actor.get_parent().remove_child(actor)
	_previous_body_parent.add_child(actor)
	actor.global_position = glob_pos
	actor.global_rotation = glob_rot
	actor.global_rotation = glob_rot
	_previous_body_parent = null

func get_has_actor() -> bool:
	return _has_actor

func get_grappled_actor() -> Actor:
	if _has_actor:
		return _grappled_actor
	else:
		# We still have a reference to the actor but it will get dropped asap
		return null
