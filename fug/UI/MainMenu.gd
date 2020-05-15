extends CanvasLayer

signal start_game

export var first_level_path : String 

onready var _message := $MessageLabel
onready var _start_button := $StartButton

func show_message(text : String) -> void:
	_message.text = text
	_message.show()

func show_game_over() -> void:
	show_message("Kill Them All again!")
	
	# @Anthoy: If you want to show the game over message you will need to load the MainMenu Scene in addition
	# to the level scene.
	# That would be cool anyways because you continue to see what is happening in the main scene while you are in
	# The menu.
	
	yield(get_tree().create_timer(1), "timeout")
	_start_button.show()

func _on_StartButton_pressed() -> void:
	GameManager.scene_changer.change_scene(first_level_path)
