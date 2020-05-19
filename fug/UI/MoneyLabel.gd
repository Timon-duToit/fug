extends Label

var _connected := false

func _process(delta: float) -> void:
	# HACK!!!
	if _connected: return
	if GameManager.level_manager:
		GameManager.level_manager.connect("money_changed", self, "_on_LevelManager_money_changed")
		text = str(GameManager.level_manager._money)
		_connected = true

func _on_LevelManager_money_changed(amount : int) -> void:
	text = str(amount)
