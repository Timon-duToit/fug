extends TextureRect

export var first_level_path : String 

func _on_New_Game_pressed():
	GameManager.scene_changer.change_scene(first_level_path)
