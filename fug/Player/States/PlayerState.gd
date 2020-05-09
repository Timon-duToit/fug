extends State

class_name PlayerState

# Animation should be its own thing
onready var _animator = owner.get_node("Body/Animator")
onready var _collider = owner.get_node("CollisionShape2D")
onready var _player : Player = owner
