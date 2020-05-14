extends Actor

class_name Player

onready var state_machine := $SMGrapplingHook
onready var body := $Body
onready var weapon : PlayerWeapon = $Body/Sword
onready var animator := $Body/Animator
onready var grappling_hook : GrapplingHook = $GrapplingHook
onready var movement_controller : PlayerDefaultMC = $PlayerMovementController

onready var _collider := $CollisionShape2D

func _ready() -> void:
	movement_controller.init(self, body)

func die() -> void:
	state_machine.change_to("Death")

func play_animation(name : String) -> void:
	animator.play(name)

func set_collider_disabled(state : bool) -> void:
	_collider.set_deferred("disabled", state)
