extends Node

class_name StateMachine

# We can't specify the State type here due to an engine bug
var state : Object

func _ready() -> void:
	state = get_child(0)
	_enter_state()
	
func change_to(node : String) -> void:
	state = get_node(node)

func _enter_state() -> void:
	state.enter(self)

func _process(delta: float) -> void:
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta: float) -> void:
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)
		
func _unhandled_key_input(event: InputEventKey) -> void:
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input

func _notification(what: int) -> void:
	if state && state.has_method("notification"):
		state.notification(what)
