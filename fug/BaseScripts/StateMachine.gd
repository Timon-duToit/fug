extends Node

class_name StateMachine

export var DEBUG := false

# We can't specify the State type here due to an engine bug
var state := Node.new()
var last_state := ""

# this state will be changed to at the next update
var queue_state := ""

func _ready() -> void:
	# queuing this is necessary to allow all ready functions to end before enter()
	queue_state = get_child(0).name
	
func change_to(node : String) -> void:
	if state.has_method("leave"):
		state.leave()
	last_state = state.name
	state = get_node(node)
	_enter_state()

func _enter_state() -> void:
	if DEBUG:
		print("FSM: entering %s" % state.name)
	state.enter(self)

func _process(delta: float) -> void:
	if queue_state:
		change_to(queue_state)
		queue_state = ""
		
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
		state.unhandled_key_input(event)

func _notification(what: int) -> void:
	if state && state.has_method("notification"):
		state.notification(what)
