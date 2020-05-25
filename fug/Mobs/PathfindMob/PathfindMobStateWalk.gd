extends State

export var speed : float = 100
export var target_speed : float = 150
export var attack_timeout : float = 0.75
export var attack_distance : float = 20

var path : PoolVector2Array
var _speed := speed
var _can_attack : float

onready var _mob : BasicMob = owner as BasicMob

func enter(controller_ : StateMachine) -> void:
	.enter(controller_)
	_mob.play_animation("Walk")
	_can_attack = false
	_callback(funcref(self, "_allow_attack"), attack_timeout)

func _allow_attack() -> void:
	_can_attack = true

func process(delta : float) -> void:
	.process(delta)
	if GameManager.level_manager && GameManager.level_manager.navigation:
		path = GameManager.level_manager.navigation.get_simple_path(_mob.global_position, GameManager.level_manager.player.global_position)

func physics_process(delta: float) -> void:
	if path:
		var goal_pos := path[1]
		_mob.movement_controller.target_speed = (goal_pos - _mob.global_position).normalized() * _speed;
	if _mob.can_see_player():
		_speed = target_speed
	else:
		_speed = speed
	
	# NOTE: both the sight calculation and the distance calculation could be done cheaper with the path!
	var delta_player := GameManager.player.position - _mob.position
	var dist = delta_player.length()
	
	if dist < attack_distance && _can_attack:
		controller.change_to("Attack")
