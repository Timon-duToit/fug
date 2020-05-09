extends KinematicBody2D

class_name Player

onready var _state_machine := $StateMachine
onready var body := $Body

func hit() -> void:
	_state_machine.change_to("Death")
