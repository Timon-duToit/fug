extends Node

signal new_game

export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	print("game over")
	yield(get_tree().create_timer(1), "timeout")
	new_game()

func new_game():
	score = 0
	emit_signal("new_game")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	var mob = Mob.instance()
	add_child(mob)
	
	mob.init($Player, $MobPath/MobSpawnLocation.position, \
	$MobPath/MobSpawnLocation.rotation + PI / 2)

	connect("new_game", mob, "_on_start_game")


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
