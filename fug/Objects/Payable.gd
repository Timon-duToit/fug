extends Node2D

signal bought

export var single_activation := true
export var price : int = 1000

var _active := true

# Perhaps do a raycast to see if the player is pointing at this? / check if the pointer is in here rather then the
# Player
# TODO: stop connecting / disconnecting on _active = false
func _on_PayArea_body_entered(player: Player) -> void:
	if not player: return
	player.connect("try_buy", self, "_on_Player_try_buy")

func _on_PayArea_body_exited(player: Player) -> void:
	if not player: return
	player.disconnect("try_buy", self, "_on_Player_try_buy")

func _on_Player_try_buy(player : Player) -> void:
	print("try buy")
	if not _active: return
	if not GameManager.level_manager: return
	
	if GameManager.level_manager.sub_money(price):
		print("bought")
		emit_signal("bought")
		if single_activation:
			_active = false
