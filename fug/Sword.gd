extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AOE.set_deferred("disabled", true)


func attack():
	$AOE.set_deferred("disabled", false)
	yield(get_tree().create_timer(1), "timeout")
	$AOE.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sword_area_entered(area):
	area.hit()
