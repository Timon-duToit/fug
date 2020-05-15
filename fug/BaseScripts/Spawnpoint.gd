extends Node2D

class_name Spawnpoint

export (PackedScene) var mob_scene
export var is_active := true
export var spawn_time : float = 5

func _ready() -> void:
	$Timer.wait_time = spawn_time

func _on_Timer_timeout() -> void:
	if is_active:
		_spawn()
	
func _spawn() -> void:
	var mob := mob_scene.instance() as Mob
	GameManager.level_manager.add_child(mob)
	mob.rotation = rand_range(0, PI * 2)
	mob.position = position
