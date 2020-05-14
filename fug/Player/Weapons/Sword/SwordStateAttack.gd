extends State

export var sweep := -PI
export var sweep_time : float = 0.2
export var windup_time : float = 0.2

var _attacking := false

onready var _sword : NewSword = owner as NewSword

func enter(collider_ : StateMachine) -> void:
	.enter(collider_)
	_attacking = false
	_callback(funcref(self, "_start_attack"), windup_time)
	_audio_effect()

func leave() -> void:
	.leave()
	_sword.collider_attack.set_deferred("disabled", true)
	_sword.hit_area.disconnect("body_entered", self, "_on_HitArea_body_entered")
	_sword.attack_done()

func _start_attack() -> void:
	_sword.collider_attack.rotation = 0
	_sword.collider_attack.set_deferred("disabled", false)
	_sword.hit_area.connect("body_entered", self, "_on_HitArea_body_entered")
	_attacking = true

func physics_process(delta: float) -> void:
	if not _attacking: return
	# TODO: move to animator
	_sword.collider_attack.rotation += sweep / sweep_time * delta
	if abs(_sword.collider_attack.rotation) > abs(sweep):
		_sword.collider_attack.rotation = sweep
		controller.change_to("Default")

func _on_HitArea_body_entered(body : Actor) -> void:
	if not body: return
	_sword.on_hit(body)

func _audio_effect() -> void:
	_sword.attack_audio.play()
	# HACK: just use a better track:
	yield(get_tree().create_timer(0.2), "timeout")
	_sword.attack_audio.stop()
