extends StaticBody2D



func _on_Payable_bought() -> void:
	if not GameManager.level_manager: return
	GameManager.level_manager.player.skill_manager.enable_dash()
