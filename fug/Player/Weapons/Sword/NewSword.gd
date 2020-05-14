extends PlayerWeapon

class_name NewSword

onready var hit_area := $HitArea
onready var collider_attack := $HitArea/ColliderAttack
onready var collider_shove := $HitArea/ColliderShove
onready var _state_machine : StateMachine = $StateMachine

onready var attack_audio := $Audio

func attack(on_hit_callback := funcref(self, "_on_hit_default")) -> void:
	.attack(on_hit_callback)
	_state_machine.change_to("Attack")

func dash_attack(on_hit_callback := funcref(self, "_on_dash_hit_default")) -> void:
	.dash_attack(on_hit_callback)
	_state_machine.change_to("Shove")

func interrupt_attack() -> void:
	_state_machine.change_to("Default")
