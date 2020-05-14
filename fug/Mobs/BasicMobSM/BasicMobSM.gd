extends Mob

class_name BasicMob

onready var movement_controller : BasicMobMC = $MovementController
onready var weapon : MobWeapon = $Weapon
onready var animator := $AnimatedSprite
onready var _state_machine : StateMachine = $StateMachine
onready var hit_audio := $Hit
onready var death_audio := $Death
onready var body_weapon : BodyWeapon = $BodyWeapon

func die() -> void:
	.die()
	_state_machine.change_to("Death")

func play_animation(animation : String) -> void:
	animator.play(animation)

func be_grappled() -> bool:
	.be_grappled()
	_state_machine.change_to("Grappled")
	return true

func get_shoved(impulse : Vector2) -> void:
	_set_grappled_physics()
	collision_layer = 0
	# TODO: add actor mass (maybe move this method to actor too?)
	movement_controller._speed = impulse
	_state_machine.change_to("Shoved")
