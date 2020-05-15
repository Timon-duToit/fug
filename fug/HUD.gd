extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")

	yield($MessageTimer, "timeout")

	$MessageLabel.text = "Kill Them All again!"
	$MessageLabel.show()

	yield(get_tree().create_timer(1), "timeout")

	$StartButton.show()


func _on_StartButton_pressed():
	SceneChanger.change_scene("res://Scenes/Main.tscn")
