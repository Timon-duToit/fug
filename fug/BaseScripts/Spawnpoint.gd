extends Node2D

class_name Spawnpoint

export (PackedScene) var mob_scene

func _on_Timer_timeout() -> void:
	_spawn()
	
func _spawn() -> void:
	var mob := mob_scene.instance() as Mob
	GameManager.level_manager.add_child(mob)
	mob.rotation = rand_range(0, PI * 2)
	mob.position = position
