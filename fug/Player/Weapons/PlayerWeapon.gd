extends Node

class_name PlayerWeapon

var _on_hit_delegate : FuncRef
var _on_dash_hit_delegate : FuncRef

func attack(on_hit := funcref(self, "_on_hit")) -> void:
	_on_hit_delegate = on_hit

func dash_attack(on_hit := funcref(self, "_on_dash_hit")) -> void:
	_on_dash_hit_delegate = on_hit

func interrupt_attack() -> void:
	pass

func _on_hit() -> void:
	pass

func _on_dash_hit() -> void:
	pass
