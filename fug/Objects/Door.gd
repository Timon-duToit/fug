extends StaticBody2D


func _on_Door_bought() -> void:
	$DoorCollider.set_deferred("disabled", true)
	$AnimationPlayer.play("FadeOut")
