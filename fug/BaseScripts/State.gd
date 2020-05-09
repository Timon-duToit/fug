extends Node

class_name State

var controller : StateMachine

func enter(controller_: StateMachine) -> void:
	controller = controller_
